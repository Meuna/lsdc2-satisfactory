#!/bin/bash
export HOME=$SATISFACTORY_HOME
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH

shutdown() {
    kill -TERM $pid
    kill -TERM $pid # A second kill is somehow needed
}

./update-server.sh

trap shutdown SIGINT SIGTERM

./Engine/Binaries/Linux/FactoryServer-Linux-Shipping FactoryGame -log -NoSteamClient -unattended ?listen -Port="$SERVER_GAME_PORT" -BeaconPort="$SERVER_BEACON_PORT" -ServerQueryPort="$SERVER_QUERY_PORT" &
pid=$!
wait $pid
