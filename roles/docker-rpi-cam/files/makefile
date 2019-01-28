default:
	@echo pass
build:
	docker build -t rpi-cam-web .
run:
  docker run -d --name=rpi-cam -p=80:80/tcp --volume=/opt/vc:/opt/vc --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web:develop
run-always:
  docker run -d --name=rpi-cam -p=80:80/tcp --volume=/opt/vc:/opt/vc --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web:develop --restart always
