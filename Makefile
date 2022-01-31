SHELL := /bin/bash
install_awscli:
	sudo apt-get update
	sudo apt-get install awscli

retrive_token:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-2.amazonaws.com
build_image: retrive_token
	docker build -t sharjeel .

tag_image: build_image
	docker tag sharjeel:test 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:test

push_image: tag_image
	docker push 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:test


deploy_ecs:
	aws ecs update-service --cluster sharjeelcluster --service sharjeelservice --task-definition 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:test


install code_deploy:
	pip install ecs-deploy

pip_version:
	pip --version