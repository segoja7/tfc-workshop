module "ack-role-for-service-accounts-eks" {

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.39.1"

  role_name = "datadog-crossplane-controller"
  role_policy_arns = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  assume_role_condition_test = "StringLike"
  oidc_providers = {
    ex = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = ["crossplane-system:provider-aws-*"]
    }
  }

  tags = {
    Environment = terraform.workspace
    Protected   = "Private"
    Layer       = "Security"
  }
}