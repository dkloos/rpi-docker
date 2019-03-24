default:
	@echo pass
dev-build: check-userconfig
	docker build -t dkloos:develop .
latest-build: check-userconfig
	docker build -t dkloos:release  -f Dockerfile.latest .
release: Dockerfile.latest
Dockerfile.latest: Dockerfile
	@echo "overwriting Dockerfile.latest"
	cp Dockerfile.latest Dockerfile.latest.bkp
	sed 's/:develop/:latest/' Dockerfile > Dockerfile.latest
check-userconfig:
	@if [ ! -d "userconfig" ]; then \
	    echo "check-userconfig: userconfig directory doesnt exist."; exit 1; \
	fi
