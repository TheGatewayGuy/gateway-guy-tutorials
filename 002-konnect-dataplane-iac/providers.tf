provider "konnect" {
  server_url = var.konnect_org_region_url
  system_account_access_token = var.konnect_system_account_access_token
}

provider "helm" {
  kubernetes = {
    config_path    = pathexpand(var.kubeconfig_path)
    config_context = var.kubeconfig_context
  }
}

provider "kubernetes" {
  config_path    = pathexpand(var.kubeconfig_path)
  config_context = var.kubeconfig_context
}

provider "tls" {}