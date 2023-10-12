
module "keda_irsa_role" {
  #checkov:skip=CKV_TF_1:"Skip"
  count = var.create_irsa_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 4.21.1"

  role_name        = var.irsa_role_name
  role_description = var.irsa_role_description

  oidc_providers = {
    main = {
      provider_arn = var.cluster_identity_oidc_provider_arn

      namespace_service_accounts = [
        "${var.namespace}:${var.service_account_name}",
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "keda_irsa_policies" {
  for_each = toset(compact(distinct(concat([var.irsa_policies], var.irsa_additional_policies))))

  policy_arn = each.value
  role       = module.keda_irsa_role[0].iam_role_name
}
