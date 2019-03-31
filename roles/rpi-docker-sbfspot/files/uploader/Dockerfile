FROM sbfspot:latest

ENV SMADATA /var/smadata
ENV SBFSPOTDIR /opt/sbfspot

ARG user=sbfspot

VOLUME ["/var/smadata", "/opt/sbfspot"]

COPY SBFspotUploadDaemon.sh $SBFSPOTDIR/SBFspotUploadDaemon.sh

USER ${user}

CMD bash -C '/opt/sbfspot/SBFspotUploadDaemon.sh';'bash'
#CMD ["/opt/sbfspot/SBFspotUploadDaemon"]
