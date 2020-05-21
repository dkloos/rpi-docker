#!/bin/bash
cp RPi_Cam_Web_Interface/bin/raspimjpeg /usr/local/bin/
chmod 755 /usr/local/bin/raspimjpeg
export LD_LIBRARY_PATH=/opt/vc/lib
sudo service nginx restart
RPi_Cam_Web_Interface/start.sh

# e.g. php5-fpm -F
if [ $# -eq 0 ]
then
    echo "Running php-fpm in foreground"
    /bin/bash
    #php-fpm7.0 -F
elif [ $1 == "debug" ]
then
    echo "debug"
    php-fpm7.0 -D
    /bin/bash
else
    echo "Invalid parameter $1"
fi
