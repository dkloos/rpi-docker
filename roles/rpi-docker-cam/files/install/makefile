default:
	@echo pass
dev-build:
	docker build -t dkloos:develop .
latest-build:
	docker build -t dkloos:release  -f Dockerfile.latest .
release: Dockerfile.latest
Dockerfile.latest: Dockerfile
	@echo "overwriting Dockerfile.latest"
	cp Dockerfile.latest Dockerfile.latest.bkp
	sed 's/:develop/:latest/' Dockerfile > Dockerfile.latest
