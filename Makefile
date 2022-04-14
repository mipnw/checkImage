.PHONY: docker-build
docker-build:
	DOCKER_BUILDKIT=1 docker build \
		-f Dockerfile \
		-t checkimage:latest \
		.

.PHONY: debug
debug:
	docker run \
	--rm \
	--entrypoint dlv \
	-p 2345:2345 \
	checkimage:latest \
		--listen=:2345 --headless --api-version=2 --log=true --log-output=debugger,debuglineerr,gdbwire,lldbout,rpc exec /usr/local/bin/checkimage -- myimage:mytag
