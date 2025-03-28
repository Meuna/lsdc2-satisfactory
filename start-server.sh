#!/bin/bash
export HOME=$LSDC2_HOME
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH

game_port=7777
beacon_port=15000

shutdown() {
    kill -TERM $pid
    kill -TERM $pid # A second kill is somehow needed
}

./update-server.sh

trap shutdown SIGINT SIGTERM

./Engine/Binaries/Linux/FactoryServer-Linux-Shipping FactoryGame -log -NoSteamClient -unattended ?listen -Port="$game_port" -BeaconPort="$beacon_port" -ServerQueryPort="$QUERY_PORT" &
pid=$!
wait $pid
