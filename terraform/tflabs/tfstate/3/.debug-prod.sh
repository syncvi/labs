export ARM_SUBSCRIPTION_ID=""
export TF_VAR_application_name="observability"
export TF_VAR_environment_name="prod"
export BACKEND_resource_group="rg-terraform-state-${TF_VAR_environment_name}"
export BACKEND_storage_account=""
export BACKEND_storage_container="tfstate"
export BACKEND_key=$TF_VAR_application_name-$TF_VAR_environment_name
terraform init \
  -backend-config="resource_group_name=${BACKEND_resource_group}" \
  -backend-config="storage_account_name=${BACKEND_storage_account}" \
  -backend-config="container_name=${BACKEND_storage_container}" \
  -backend-config="key=${BACKEND_key}"

terraform "$*"

rm -rf .terraform
