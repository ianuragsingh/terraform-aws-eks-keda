resource "helm_release" "keda" {
  name       = var.helm_release_name
  repository = var.helm_chart_repo_url
  chart      = var.helm_chart_name
  version    = var.helm_chart_version

  create_namespace = var.helm_create_namespace
  namespace        = var.namespace

  timeout         = var.helm_timeout
  cleanup_on_fail = var.helm_cleanup_on_fail
  max_history     = var.helm_release_max_history

  values = [
    templatefile("${path.module}/templates/keda.yaml", local.keda_chart_values),
  ]
}

locals {
  keda_chart_values = {
    create_service_account = var.create_service_account
    service_account_name   = var.service_account_name

    annotations = jsonencode({
        "eks.amazonaws.com/role-arn" = var.create_irsa_role ? module.keda_irsa_role[0].iam_role_arn : ""
    })
  }
}