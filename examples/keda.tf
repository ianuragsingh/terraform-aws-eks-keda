module "keda" {
  source = "git::https://github.com/ianuragsingh/terraform-aws-eks-keda.git?ref=v0.3.0"

  helm_chart_name    = "keda"
  helm_release_name  = "keda"
  helm_chart_version = "2.12.0"

  helm_create_namespace = true
  namespace             = "keda"

  http_addon_enabled = true

  cluster_identity_oidc_provider_arn = "provide your cluster identity oidc provider arn"
}
