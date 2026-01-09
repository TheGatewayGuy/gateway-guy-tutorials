output "konnect_cluster_prefix" {
  value = local.konnect_cluster_prefix
}

output "konnect_control_plane_id" {
  value = konnect_gateway_control_plane.gateway_control_plane.id
}

output "konnect_control_plane_name" {
  value = konnect_gateway_control_plane.gateway_control_plane.name
}

output "environment" {
  value = var.environment
}

output "cluster_key_pem" {
  value     = tls_private_key.cluster.private_key_pem
  sensitive = true
}

output "cluster_cert_pem" {
  value = tls_self_signed_cert.cluster.cert_pem
}