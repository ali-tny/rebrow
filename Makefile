docker-build:
	# Building the docker image "rebrow"
	docker build -t rebrow .

serve-dev:
	pipenv run python $(shell pwd)/rebrow/server.py

serve-gunicorn:
	pipenv run gunicorn \
		--config $(shell pwd)/deploy/gunicorn.conf\
		--log-config $(shell pwd)/deploy/logging.conf\
		rebrow.server:app
