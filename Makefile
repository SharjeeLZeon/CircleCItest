Tags := nginx

SHELL := /bin/bash
install_awscli:
	sudo apt-get update
	sudo apt-get install awscli

retrive_token: install_awscli
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-2.amazonaws.com
build_image: retrive_token
	docker build -t sharjeel:${Tags} .

tag_image: build_image
	docker tag sharjeel:${Tags} 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:${Tags}

push_image: tag_image
	docker push 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:${Tags}

register_task_definition:
	aws ecs register-task-definition --cli-input-json file://task-definition.json


deploy_ecs:
	aws ecs update-service --cluster sharjeelcluster --service sharjeelservice --task-definition 'sharjeel_taskdef'

pip_install:
	ls /home/circleci/project
	ls /usr/bin
	sudo apt update -y
	sudo apt install -y python3-pip
	sudo pip install -y ecs-deploy