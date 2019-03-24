FROM balenalib/rpi-raspbian:jessie

MAINTAINER "DK"

RUN mkdir -p /rpi-cam-web && \
     mkdir -p /opt/vc/bin && \
    mkdir -p /run/php/ && \
    touch /run/php/php7.0-fpm.sock
WORKDIR /rpi-cam-web

# Adding php 7 repo
RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list
RUN echo "Package: *\nPin: release n=jessie\nPin-Priority: 600" > /etc/apt/preferences

# installing and refreshing of packages
RUN apt-get update -y && \
    apt-get install -y git apt-utils libraspberrypi0 && \
    apt-get install -y -t stretch php7.0-cli nginx php7.0-fpm php7.0-cli php7.0-common php7.0-apcu apache2-utils gpac motion zip libav-tools gstreamer1.0

#configure lib
RUN echo /opt/vc/lib > /etc/ld.so.conf \
    ldconfig

# Clonging project from github
RUN git clone https://github.com/silvanmelchior/RPi_Cam_Web_Interface.git
    # comment the following line to download the untested most recent version
    #cd RPi_Cam_Web_Interface; git checkout -q master; cd .. && \
RUN chmod u+x RPi_Cam_Web_Interface/*.sh
	
# Removing 'sudo' lines from executables
RUN mkdir -p /run/shm/mjpeg && \
    sed -i '/sudoers/c\\# sudoers removed' RPi_Cam_Web_Interface/install.sh && \
#    sed -i '/\/opt\/vc\/bin\//c\\echo raspimjpeg related install.sh line removed' RPi_Cam_Web_Interface/install.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/install.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/start.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/stop.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/remove.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/update.sh && \
    sed -i 's/sudo //g' RPi_Cam_Web_Interface/RPi_Cam_Web_Interface_Installer.sh && \
    sed -i 's/sudo shutdown -r now//g' RPi_Cam_Web_Interface/www/macros/error_hard.sh && \
    rm RPi_Cam_Web_Interface/www/macros/error_hard.sh

# copy motion.conf file to host
COPY motion.conf /etc/motion/
    

WORKDIR /rpi-cam-web/RPi_Cam_Web_Interface
# config file for 'RPi_Cam_eb_Interface'
COPY config.txt ./

# Run 'RPi_Cam_Web_Interface' installation (q= quiet mode)
RUN ./install.sh q

# Adding scripts to macros folder
COPY motion_event.sh /var/www/macros 
COPY uconfig /var/www
COPY schedule.json /var/www
RUN chmod 755 /var/www/macros/*.sh && \
    chown www-data:www-data /var/www/macros/*.sh

WORKDIR /rpi-cam-web
# ENTRYPOINT definition
RUN chmod 755 RPi_Cam_Web_Interface/bin/raspimjpeg
#RUN if [ ! -e /usr/local/bin/raspimjpeg ]; then sudo ln -s RPi_Cam_Web_Interface/bin/raspimjpeg /usr/local/bin/raspimjpeg; fi
	
# ENTRYPOINT definition
COPY docker-entry.sh ./
RUN chmod u+x docker-entry.sh && \
    ln docker-entry.sh /usr/local/bin/rpi-cam-web	
ENTRYPOINT ["rpi-cam-web"]
