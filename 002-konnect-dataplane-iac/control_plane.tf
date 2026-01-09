resource "konnect_gateway_control_plane" "gateway_control_plane" {
  auth_type     = var.auth_type
  cloud_gateway = var.cloud_gateway
  cluster_type  = var.cluster_type
  description   = "${var.gateway_name} control plane"
  labels        = var.labels
  name          = replace(lower(var.gateway_name)," ","_")
}

resource "konnect_gateway_data_plane_client_certificate" "cp_certificate" {
  cert             = tls_self_signed_cert.cluster.cert_pem
  control_plane_id = konnect_gateway_control_plane.gateway_control_plane.id
}