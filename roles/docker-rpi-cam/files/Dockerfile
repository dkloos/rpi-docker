FROM resin/rpi-raspbian:jessie

MAINTAINER "DK"

# installing and refreshing of packages
RUN apt-get update -y && \
    apt-get install -y psmisc dialog nginx php5-fpm php5-cli php5-common php-apc apache2-utils gpac motion zip libav-tools gstreamer1.0-tools git

# config file for 'RPi_Cam_eb_Interface'
COPY config.txt ./RPi_Cam_Web_Interface/

# Run 'RPi_Cam_Web_Interface' installation (q= quiet mode)
RUN RPi_Cam_Web_Interface/install.sh q

RUN mkdir -p /rpi-cam-web
WORKDIR /rpi-cam-web

# Clonging project from github
RUN git clone https://github.com/silvanmelchior/RPi_Cam_Web_Interface.git && \
    # comment the following line to download the untested most recent version
    cd RPi_Cam_Web_Interface; git checkout -q master; cd .. && \
    chmod u+x RPi_Cam_Web_Interface/*.sh
	
# workarounds
RUN mkdir -p /run/shm/mjpeg && \
    sed -i '/sudoers/c\\# sudoers removed' RPi_Cam_Web_Interface/install.sh && \
    sed -i '/\/opt\/vc\/bin\//c\\echo raspimjpeg related install.sh line removed' RPi_Cam_Web_Interface/install.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/install.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/start.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/stop.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/remove.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/update.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/RPi_Cam_Web_Interface_Installer.sh && \
    sed -i 's/sudo shutdown -r now//g' RPi_Cam_Web_Interface/www/macros/error_hard.sh && \
    rm RPi_Cam_Web_Interface/www/macros/error_hard.sh

# ENTRYPOINT definition
RUN ldconfig \
    cp RPi_Cam_Web_Interface/bin/raspimjpeg /opt/vc/bin/ \
    chmod 755 /opt/vc/bin/raspimjpeg \
    if [ ! -e /usr/bin/raspimjpeg ]; then sudo ln -s /opt/vc/bin/raspimjpeg /usr/bin/raspimjpeg fi
	
# ENTRYPOINT definition
COPY docker-entry.sh ./
RUN chmod u+x docker-entry.sh && \
    ln docker-entry.sh /usr/local/bin/rpi-cam-web	
ENTRYPOINT ["rpi-cam-web"]
