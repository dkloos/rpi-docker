default:
	@echo pass
docker-inst:
	ansible-playbook -l rpi-cam rpi-docker-cam.yml -t rpi-docker-install
build-cam:
	ansible-playbook -l rpi-cam rpi-docker-cam.yml -t rpi-docker-cam
build-sbfspot:
	ansible-playbook -l rpi-cam rpi-docker-sbfspot.yml -t build 
run-sbfspot:
	ansible-playbook -l rpi-cam rpi-docker-sbfspot.yml -t run 
run-cam:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,destination=/data --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web 
run-cam-always:
	docker run -d --name=rpi-cam -p=80:80/tcp --mount source=nfscam,destination=/data --device=/dev/vchiq --device=/dev/vcsm rpi-cam-web --restart always
