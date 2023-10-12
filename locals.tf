
locals {
  keda_chart_values = {
    create_service_account = var.create_service_account
    service_account_name   = var.service_account_name

    annotations = jsonencode({
        "eks.amazonaws.com/role-arn" = var.create_irsa_role ? module.keda_irsa_role[0].iam_role_arn : ""
    })
  }
}
