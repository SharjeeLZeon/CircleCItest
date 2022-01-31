SHELL := /bin/bash
install_awscli:
	sudo apt-get update
	sudo apt-get install awscli


one:
	pwd

two: three
	ls

three:
	ls -l

#retrive_token:
#	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-2.amazonaws.com
#build_image:
#	docker build -t sharjeel .

#tag_image:
#	docker tag sharjeel:latest 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:test

#push_image:
#	docker push 489994096722.dkr.ecr.us-east-2.amazonaws.com/sharjeel:test
