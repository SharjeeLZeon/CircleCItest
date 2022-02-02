SHELL := /bin/bash
install_packages:
	sudo apt-get update
	sudo apt-get install awscli
	sudo apt update -y
	sudo apt install -y python3-pip
	sudo pip install ecs-deploy


commit_hash:
	$(eval GIT_COMMIT = $(shell git clone https://github.com/SharjeeLZeon/CircleCItest.git buildarea/project && cd buildarea/project && git rev-parse HEAD))
	echo $(GIT_COMMIT)
	later =  $(AWS_ACCOUNT_ID)
	one = one ${later_variable}
	echo $(one)

retrive_token:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-2.amazonaws.com

build_image: retrive_token
	docker build -t sharjeel:$(GIT_COMMIT) .

tag_image:
	docker tag sharjeel:$(GIT_COMMIT) 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(GIT_COMMIT)

push_image:
	docker push 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(GIT_COMMIT)



















#register_task_definition:
#	aws ecs register-task-definition --cli-input-json file://task-definition.json



#deployment_ecs:
#	ecs deploy sharjeelcluster sharjeelservice --task arn:aws:ecs:us-east-2:489994096722:task-definition/sharjeeltask:${REVISION} --timeout 600



#deploy_ecs:
#	aws ecs update-service --cluster sharjeelcluster --service sharjeelservice --task-definition 'sharjeel_taskdef'


