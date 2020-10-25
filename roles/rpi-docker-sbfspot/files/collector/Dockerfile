FROM sbfspot:latest

ENV SMADATA /var/smadata
ENV SBFSPOTDIR /opt/sbfspot

ARG user=sbfspot

VOLUME ["/var/smadata", "/opt/sbfspot"]

COPY SBFspot.sh $SBFSPOTDIR/SBFspot.sh

USER ${user}

ENTRYPOINT ["/opt/sbfspot/SBFspot.sh"]
CMD ["-v"]
