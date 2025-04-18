FROM docker.io/steamcmd/steamcmd:ubuntu

ENV LSDC2_USER=lsdc2 \
    LSDC2_HOME=/lsdc2 \
    LSDC2_UID=2000 \
    LSDC2_GID=2000

WORKDIR $LSDC2_HOME

COPY update-server.sh $LSDC2_HOME
RUN groupadd -g $LSDC2_GID -o $LSDC2_USER \
    && useradd -g $LSDC2_GID -u $LSDC2_UID -d $LSDC2_HOME -o --no-create-home $LSDC2_USER \
    && chown -R $LSDC2_USER:$LSDC2_USER $LSDC2_HOME \
    && chmod u+x update-server.sh \
    && su $LSDC2_USER ./update-server.sh \
    && rm -rf /root/.steam

ADD https://github.com/Meuna/lsdc2-serverwrap/releases/download/v0.5.1/serverwrap /usr/local/bin
COPY start-server.sh $LSDC2_HOME
RUN chown $LSDC2_USER:$LSDC2_USER start-server.sh \
    && chmod +x /usr/local/bin/serverwrap start-server.sh

ENV GAME_SAVEDIR=$LSDC2_HOME/.config/Epic/FactoryGame/Saved/SaveGames \
    GAME_SAVENAME=lsdc2 \
    QUERY_PORT=15777

ENV LSDC2_SNIFF_FILTER="udp dst port $QUERY_PORT" \
    LSDC2_PERSIST_FILES="ServerSettings.$QUERY_PORT;server" \
    LSDC2_ZIPFROM=$GAME_SAVEDIR/worlds_local

ENTRYPOINT ["serverwrap"]
CMD ["./start-server.sh"]
