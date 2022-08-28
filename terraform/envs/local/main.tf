# SEC-0001: remove password and use a valid and secure way off configuring credentials
terraform {
  backend "pg" {
    conn_str = "postgres://postgres:postgres@localhost:5432/terraform_backend?sslmode=disable"
  }
}

module "kubernetes-cluster" {
  source = "../../modules/kubernetes-cluster"
}
