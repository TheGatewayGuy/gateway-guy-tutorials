locals {
  konnect_cluster_prefix = replace(replace(konnect_gateway_control_plane.gateway_control_plane.config.control_plane_endpoint, "https://", ""), ".eu.cp0.konghq.com", "")
}