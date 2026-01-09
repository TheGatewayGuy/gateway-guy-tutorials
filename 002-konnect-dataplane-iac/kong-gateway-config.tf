resource "konnect_gateway_service" "echo_service" {
  count = var.apply_kong_config ? 1 : 0
  enabled = true
  name = "echo-service"
  connect_timeout = 60000
  host = "httpbin.org"
  path = "/anything"
  port = 443
  protocol = "https"
  read_timeout = 60000
  retries = 5
  write_timeout = 60000

  control_plane_id = konnect_gateway_control_plane.gateway_control_plane.id
}

resource "konnect_gateway_route" "echo_route" {
  count = var.apply_kong_config ? 1 : 0
  name = "echo-route"
  https_redirect_status_code = 426
  path_handling = "v0"
  paths = ["/echo"]
  preserve_host = false
  protocols = ["http", "https"]
  regex_priority = 0
  request_buffering = true
  response_buffering = true
  strip_path = true

  service = {
    id = konnect_gateway_service.echo_service.0.id
  }

  control_plane_id = konnect_gateway_control_plane.gateway_control_plane.id
}

