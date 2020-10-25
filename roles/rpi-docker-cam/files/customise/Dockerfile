FROM dkloos:develop

MAINTAINER "DK"

# user configs, used to copy over exisiting configurations, TODO: add motion
COPY userconfig/uconfig /var/www/
COPY userconfig/schedule.json /var/www/
RUN chown www-data:www-data /var/www/uconfig /var/www/schedule.json

ENTRYPOINT ["rpi-cam-web"]
