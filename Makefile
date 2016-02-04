NAME = 452158872079.dkr.ecr.us-east-1.amazonaws.com/mage
VERSION = 0.1.70

.PHONY: all build release

all: build

build:	
	docker pull maven:3.3.3-jdk-8
	docker run maven:3.3.3-jdk-8 mvn clean package -DskipTests=true
	docker build -t $(NAME):$(VERSION) .

release: 
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME):$(VERSION)
clean:
	docker rmi $(NAME):$(VERSION)
