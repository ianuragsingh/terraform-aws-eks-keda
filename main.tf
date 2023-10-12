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

resource "helm_release" "http-add-on" {
  count = var.http_addon_enabled ? 1 : 0

  name       = var.http_addon_helm_release_name
  repository = var.helm_chart_repo_url
  chart      = var.http_addon_helm_chart_name
  version    = var.http_addon_helm_chart_version
  namespace  = var.namespace

  depends_on = [
    helm_release.keda
  ]
}
