# NOTE: This module assumes that Kubernetes/Helm providers are configured at the root level.
# It is scaffolded for future use once the EKS cluster and kubeconfig are available.

resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = var.namespace
  version    = var.chart_version

  create_namespace = true

  values = [yamlencode(var.values)]
}
