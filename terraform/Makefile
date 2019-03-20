AWS_CREDENTIALS_PATH=/local/path/to/your/aws/credentials/file# EDIT

.PHONY: docker_build \
		tf_be \
		tf_init \
		tf_plan \
		tf_apply \
		tf_rm \
		tf_show \
		tf_re \
		tf_sl \
		sh

docker_build: # build docker images used by commands
	cd docker/terraform && docker build -t terraform . # EDIT

tf_be: # create terraform backend resources (s3 bucket + ddb table)
	docker run --rm \
		-v $(PWD):/usr/src/app \
		-v $(AWS_CREDENTIALS_PATH):/root/.aws/credentials \
		-w /usr/src/app/terraform/backend \
		terraform bash -c "\
			rm -f terraform.tfstate* && \
			terraform init && \
			terraform plan && \
			terraform apply -auto-approve"

tf_init: # terraform init - install TF plugins (AWS)
	TF_CMD=init AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_plan: # terraform plan
	TF_CMD=plan AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_apply: # terraform apply
	TF_CMD=apply AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_rm: # terraform destroy
	TF_CMD=destroy AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_show: # terraform show
	TF_CMD=show AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_re: # terraform refresh
	TF_CMD=refresh AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

tf_sl: # terraform stack list
	TF_CMD="state list" AWS_CREDENTIALS_PATH=$(AWS_CREDENTIALS_PATH) $(PWD)/run.sh

sh: # terraform shell
	docker run --rm -it \
		-v $(PWD):/usr/src/app \
		-v $(AWS_CREDENTIALS_PATH):/root/.aws/credentials \
		-w /usr/src/app/terraform \
		terraform bash
