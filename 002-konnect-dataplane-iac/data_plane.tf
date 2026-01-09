resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.kong_namespace
  }
}

resource "kubernetes_secret_v1" "kong_cluster_cert" {
  metadata {
    name      = "kong-cluster-cert"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = tls_self_signed_cert.cluster.cert_pem
    "tls.key" = tls_private_key.cluster.private_key_pem
  }
}

resource "helm_release" "kong_dp" {
  name       = "kong-dataplane"
  namespace  = kubernetes_namespace_v1.namespace.metadata[0].name
  repository = "https://charts.konghq.com"
  chart      = "kong"
  version    = var.kong_chart_version

  values = [
    templatefile("./files/values.yaml.tpl", {
      konnect_cluster_prefix  = local.konnect_cluster_prefix
      kong_docker_repo        = var.kong_docker_repo
      kong_gateway_version    = var.kong_gateway_version
      proxy_service_type      = var.proxy_service_type
    })
  ]

  depends_on = [
    konnect_gateway_control_plane.gateway_control_plane,
    konnect_gateway_data_plane_client_certificate.cp_certificate,
    kubernetes_namespace_v1.namespace,
    kubernetes_secret_v1.kong_cluster_cert
  ]
}