#!/bin/bash
export HOME=$SATISFACTORY_HOME
steamcmd +force_install_dir $SATISFACTORY_HOME +login anonymous +app_update $SATISFACTORY_SERVER_APPID -beta public +quit
