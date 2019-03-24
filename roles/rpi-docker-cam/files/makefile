default:
	@echo pass
build:
	docker build -t rpi-cam-web .
run:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,target=/var/www/media --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web
run-always:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,target=/var/www/media --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web --restart always
rmi:
	docker rmi $(shell docker images --filter dangling=true -q) || true
rm:
	docker rm -v $(shell docker ps --filter status=exited -q) || true
