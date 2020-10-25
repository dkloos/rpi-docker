default:
	@echo pass
dev-build:
	docker build -t dkloos:develop-setup .
	docker run -it --name=rpi-cam-web-setup -p=80:80/tcp --volume=/opt/vc:/opt/vc --device=/dev/vchiq --device=/dev/vcsm dkloos:develop-setup
	docker commit rpi-cam-web-setup dkloos:develop-preinstall
	+$(MAKE) .rm-run
	docker rmi dkloos:develop-setup
latest-build:
	docker build -t dkloos:release-setup -f Dockerfile.latest .
	docker run -it --name=rpi-cam-web-setup -p=80:80/tcp --volume=/opt/vc:/opt/vc --device=/dev/vchiq --device=/dev/vcsm dkloos:release-setup
	docker commit rpi-cam-web-setup dkloos:release-preinstall
	+$(MAKE) .rm-run
	docker rmi dkloos:release-setup
.rm-run:
	docker rm rpi-cam-web-setup
release: Dockerfile.latest
Dockerfile.latest:
	@echo "overwriting Dockerfile.latest"
	cp Dockerfile.latest Dockerfile.latest.bkp
	cp Dockerfile Dockerfile.latest
