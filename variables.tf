#------ variables for keda --------
variable "helm_chart_name" {
  description = "Helm chart name to be installed"
  type        = string
  default     = "keda"
}

variable "helm_chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = "2.12.0"
}

variable "helm_release_name" {
  description = "Helm release name"
  type        = string
  default     = "keda"
}

variable "helm_chart_repo_url" {
  description = "Helm chart repository url"
  type        = string
  default     = "https://kedacore.github.io/charts"
}

variable "helm_create_namespace" {
  description = "Create the namespace if not exist"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "The Kuebernetes namespace in which the keda will be installed"
  type        = string
  default     = "keda"
}

variable "cluster_identity_oidc_provider_arn" {
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
  type        = string
}

variable "create_service_account" {
  description = "Whether to create Service Account"
  type        = bool
  default     = true
}

variable "service_account_name" {
  description = "The k8s keda controller service account name"
  type        = string
  default     = "keda-operator"
}

variable "create_irsa_role" {
  description = "Whether to create IRSA role and annotate service account"
  type        = bool
  default     = true
}

variable "irsa_role_name" {
  description = "The IRSA role name for keda"
  type        = string
  default     = "keda-irsa-role"
}

variable "irsa_role_description" {
  description = "The IRSA role description for keda controller"
  type        = string
  default     = "Service account role for Keda"
}

variable "irsa_policies" {
  description = "IRSA policies to be attached to default role."
  type        = list(string)
  default     = []
}

variable "irsa_additional_policies" {
  description = "Additional policies to be attached to default role. User should provide full ARN of the policy."
  type        = list(string)
  default     = []
}

variable "values" {
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://github.com/kedacore/charts/tree/main/keda"
  type        = string
  default     = ""
}

variable "helm_timeout" {
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
  type        = number
  default     = 300

}
variable "helm_cleanup_on_fail" {
  description = "Allow deletion of new resources created in this helm upgrade when upgrade fails"
  type        = bool
  default     = false
}

variable "helm_release_max_history" {
  description = "Maximum number of release versions stored per release"
  type        = number
  default     = 0
}
