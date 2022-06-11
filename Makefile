init:
	terraform init -input=false

plan: init
	terraform plan -input=false

apply: init plan
	terraform apply -input=false -auto-approve

destroy: init plan
	terraform destroy -auto-approve

validate:
	terraform validate

fmt:
	terraform fmt -check -diff -recursive .

tflint_version:
	tflint --version

tflint_init:
	tflint --init

tflint_run:
	tflint -f compact