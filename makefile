default:
	@echo pass
docker-inst:
	ansible-playbook -l rpi-cam rpi-docker-cam.yml -t rpi-docker-install
docker-rpi-cam:
	ansible-playbook -l rpi-cam rpi-docker-cam.yml -t rpi-docker-cam
run:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,destination=/data --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web 
run-always:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,destination=/data --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web --restart always
