SHELL := /bin/bash

COMMIT = $(shell git rev-parse --short HEAD)

install_awscli_packages:
	sudo apt-get update
	sudo apt-get install awscli

retrive_token:
	eval $$\( aws ecr get-login --no-include-email --region ${AWS_DEFAULT_REGION}\)

build_image: retrive_token
	docker build -t sharjeel:$(COMMIT) .

tag_image:
	docker tag sharjeel:$(COMMIT) $(AWS_ACCOUNT_ID).dkr.ecr.us-east-1.amazonaws.com/sharjeel:$(COMMIT)

push_image:
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.us-east-1.amazonaws.com/sharjeel:$(COMMIT)


ecs_deploy_packages:
	sudo apt update -y
	sudo apt install -y python3-pip
	sudo pip install ecs-deploy

deploy_ecs_cluster:
	ecs deploy sharjeelcluster sharjeelservice --task sharjeeltaskdef