#!/bin/sh
if [ -z "$SENTINEL_HOST" ]
then
    REDIS_MASTER=`redis-cli -h $SENTINEL_HOST -p $SENTINEL_PORT --raw SENTINEL masters | grep ip -A 1 | grep -v ip`
    java -jar mage-0.1.87-SNAPSHOT.jar server config.yml&
    while true; do
        NEW_MASTER=`redis-cli -h $SENTINEL_HOST -p $SENTINEL_PORT --raw SENTINEL masters | grep ip -A 1 | grep -v ip`
        if [ $REDIS_MASTER -ne $NEW_MASTER ]
        then
            ps
        fi
        sleep 1
    done
else
    java -jar mage-0.1.87-SNAPSHOT.jar server config.yml
fi
