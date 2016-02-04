# Mage Makefile for building and pushing a containerized application to Amazon ECR
# By Anderson Brandao (andersonbn.itpro@gmail.com)

REGISTRY = 452158872079.dkr.ecr.us-east-1.amazonaws.com
IMAGE =  mage
VERSION = 0.1.70
MVN_VERSION = 3.3.3-jdk-8

.PHONY: all build release

all: build

build:	
	docker pull maven:$(MVN_VERSION)
	docker run -it  -v $(shell pwd):/usr/src/mymaven -w /usr/src/mymaven maven:$(MVN_VERSION)  mvn clean package -DskipTests=true
	docker build -t $(REGISTRY)/$(IMAGE):$(VERSION) .

release: 
	@if ! docker images $(REGISTRY)/$(IMAGE) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(REGISTRY)/$(IMAGE) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)
clean:
	docker rmi $(REGISTRY)/$(IMAGE):$(VERSION)
