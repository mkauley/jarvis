#!/bin/bash
pushd ~/code/jarvis/docker

if [ "$1" == "start" ]; then
    if [ "$2" == "all" ]; then
        echo "Starting all containers..."
        docker compose up --detach
    else
        echo "Starting [$2] container..."
        docker compose up --detach $2
    fi

elif [ "$1" == "stop" ]; then
    if [ "$2" == "all" ]; then
        echo "Stopping all containers..."
        docker compose down
    else
        echo "Stopping [$2] container..."
        docker compose stop $2
    fi

elif [ "$1" == "restart" ]; then
    echo "Restarting [$2] container..."
    docker compose restart $2

elif [ "$1" == "logs" ]; then
    docker compose logs -f $2

else
    echo "Usage: $0 start|stop|restart|logs [all|<service>]"
    exit 1
fi

popd
