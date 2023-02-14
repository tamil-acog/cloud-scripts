run_terraform()
{
  cd $6
  terraform destroy -auto-approve
  terraform init
  terraform plan -var-file="variables.tfvars.json" -out plan.out
  terraform apply plan.out
}

run_terraform $1 $2 $3 $4 $5 $6