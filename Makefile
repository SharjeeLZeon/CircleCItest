SHELL := /bin/bash
COMMIT = $(shell git rev-parse --short HEAD)
install_packages:
	sudo apt-get update
	sudo apt-get install awscli
	sudo apt update -y
	sudo apt install -y python3-pip
	sudo pip install ecs-deploy


retrive_token:
	sudo apt-get update
	sudo apt-get install awscli
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com

build_image: retrive_token
	docker build -t sharjeel:${COMMIT}.

tag_image:
	docker tag sharjeel:$(COMMIT) $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(COMMIT)

push_image:
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(COMMIT)



















#register_task_definition:
#	aws ecs register-task-definition --cli-input-json file://task-definition.json



#deployment_ecs:
#	ecs deploy sharjeelcluster sharjeelservice --task arn:aws:ecs:us-east-2:489994096722:task-definition/sharjeeltask:${REVISION} --timeout 600



#deploy_ecs:
#	aws ecs update-service --cluster sharjeelcluster --service sharjeelservice --task-definition 'sharjeel_taskdef'


