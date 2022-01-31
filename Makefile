SHELL := /bin/bash
install_awscli:
	sudo apt-get update
	sudo apt-get install awscli
	sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest

retrive_token:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-2.amazonaws.com
build_image: retrive_token
	docker build -t sharjeel .

tag_image: build_image
	docker tag sharjeel:latest 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:latest

push_image: tag_image
	docker push 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:latest


deploy_ecs:
	ecs deploy sharjeelcluster sharjeelservice --task-definition 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:latest