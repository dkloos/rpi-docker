FROM balenalib/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV SBFSPOT_HOME /home/sbfspot
ENV SMADATA /var/smadata
ENV SBFSPOTDIR /opt/sbfspot

ARG user=sbfspot
ARG group=sbfspot
ARG uid=2000
ARG gid=2000

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${gid} ${group} \
	&& useradd -d "$SBFSPOT_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

# From version 3.0 no longer uploads to PVoutput.org. This functionality is now in the hands of an upload service (Windows) or daemon (Linux).
# So libcurl3-dev is needed only if you are uploading data to PVoutput.org.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
        wget \
        bluetooth \
	libbluetooth-dev \
	libboost-all-dev \
	sqlite3 \
	libsqlite3-dev \
	libcurl3-dev \
	make \
	g++ \
	&& rm -rf /var/lib/apt/lists/*

# Make SBFspot and move installation to SBFSPOTDIR. SBFspot by default installs to /usr/local/bin/sbfspot.3
WORKDIR $SBFSPOT_HOME
RUN mkdir sbfspot.3
RUN wget -N https://github.com/SBFspot/SBFspot/archive/V3.5.0.tar.gz
RUN tar -xvf V3.5.0.tar.gz -C sbfspot.3 --strip-components 1

# Compile SBFspot
WORKDIR $SBFSPOT_HOME/sbfspot.3/SBFspot
RUN make sqlite
RUN make install_sqlite

# Compile SBFspotUploadDaemon
WORKDIR $SBFSPOT_HOME/sbfspot.3/SBFspotUploadDaemon
RUN make sqlite
RUN make install_sqlite

# Deinstall compiler since we no longer need it
RUN apt-get purge \
	g++ \
	make \
	&& apt-get autoremove \
	&& apt-get autoclean
	
RUN mv /usr/local/bin/sbfspot.3 $SBFSPOTDIR \
	&& cp $SBFSPOT_HOME/sbfspot.3/SBFspot/CreateSQLiteDB.sql $SBFSPOTDIR \
	&& rm -rf $SBFSPOT_HOME/sbfspot.3

# Setup data directory
RUN mkdir $SMADATA && chown -R ${user}:${group} $SMADATA

VOLUME ["/var/smadata", "/opt/sbfspot"]

# expose sqlite port (TODO: remove later on)
EXPOSE 12345

USER ${user}

CMD ["/bin/bash"]
