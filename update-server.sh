#!/bin/bash
export HOME=$LSDC2_HOME
export PATH=$PATH:/usr/games
satisfactory_server_appid=1690800
steamcmd +force_install_dir $LSDC2_HOME +login anonymous +app_update $satisfactory_server_appid -beta public +quit
