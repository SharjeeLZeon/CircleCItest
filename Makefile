SHELL := /bin/bash
install_packages:
	sudo apt-get update
	sudo apt-get install awscli
	sudo apt update -y
	sudo apt install -y python3-pip
	sudo pip install ecs-deploy


commit_hash:
	sudo apt-get update
	sudo apt-get install awscli
	$(eval GIT_COMMIT = $(shell git clone https://github.com/SharjeeLZeon/CircleCItest.git buildarea/project && cd buildarea/project && git rev-parse HEAD))
	echo $(GIT_COMMIT)

aws_account_id:
	account_id =  $(AWS_ACCOUNT_ID)

retrive_token:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com

build_image: retrive_token
	docker build -t sharjeel:$(GIT_COMMIT) .

tag_image:
	docker tag sharjeel:$(GIT_COMMIT) $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(GIT_COMMIT)

push_image:
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.us-east-2.amazonaws.com/sharjeel:$(GIT_COMMIT)



















#register_task_definition:
#	aws ecs register-task-definition --cli-input-json file://task-definition.json



#deployment_ecs:
#	ecs deploy sharjeelcluster sharjeelservice --task arn:aws:ecs:us-east-2:489994096722:task-definition/sharjeeltask:${REVISION} --timeout 600



#deploy_ecs:
#	aws ecs update-service --cluster sharjeelcluster --service sharjeelservice --task-definition 'sharjeel_taskdef'


