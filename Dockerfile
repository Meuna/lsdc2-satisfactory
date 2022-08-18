from steamcmd/steamcmd:ubuntu

ENV SATISFACTORY_SERVER_APPID=1690800 \
    SATISFACTORY_HOME=/satisfactory/

ENV CONFDIR=$SATISFACTORY_HOME/FactoryGame/Saved/Config/LinuxServer/ \
    SAVEDIR=$SATISFACTORY_HOME/.config/Epic/FactoryGame/Saved/SaveGames \
    SERVER_GAME_PORT=7777 \
    SERVER_BEACON_PORT=15000 \
    SERVER_QUERY_PORT=15777

ENV LSDC2_SNIFF_IFACE="eth0" \
    LSDC2_SNIFF_FILTER="udp port $SERVER_QUERY_PORT" \
    LSDC2_CWD=$SATISFACTORY_HOME \
    LSDC2_UID=1000 \
    LSDC2_GID=1000 \
    LSDC2_PERSIST_FILES="ServerSettings.$SERVER_QUERY_PORT;server" \
    LSDC2_ZIP=1 \
    LSDC2_ZIPFROM=$SAVEDIR

WORKDIR $SATISFACTORY_HOME

ADD https://github.com/Meuna/lsdc2-serverwrap/releases/download/v0.2.0/serverwrap /serverwrap

COPY start-server.sh update-server.sh $SATISFACTORY_HOME
RUN groupadd -g $LSDC2_GID -o satisfactory \
    && useradd -g $LSDC2_GID -u $LSDC2_UID -d $SATISFACTORY_HOME -o --no-create-home satisfactory \
    && chmod u+x /serverwrap start-server.sh update-server.sh \
    && chown -R satisfactory:satisfactory $SATISFACTORY_HOME \
    && rm -rf /root/.steam

EXPOSE 7777/udp 15000/udp 15777/udp
ENTRYPOINT ["/serverwrap"]
CMD ["./start-server.sh"]
