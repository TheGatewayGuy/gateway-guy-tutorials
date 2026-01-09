variable "konnect_system_account_access_token" {
  type        = string
  description = "System account token"
}

variable "konnect_org_region_url" {
  type        = string
  description = "The org region URL used for provider"
  default = "https://eu.api.konghq.com"
}

/**
* Variables for Control Plane
 */
variable "gateway_name" {
  type        = string
  description = "The Gateway Name"
}

variable "cloud_gateway" {
  type        = bool
  description = "Whether this control plane is cloud gateway or self hosted"
  default     = false
}

variable "environment" {
  type        = string
  description = "The application environment (dev,uat,prev or prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "uat", "prev", "prod"], var.environment)
    error_message = "Allowed values are: dev, uat, prev or prod."
  }
}

variable "labels" {
  type = map(string)
  description = ""
  default = {}
}

variable "auth_type" {
  type        = string
  description = "The certificate authentication type"
  default     = "pinned_client_certs"

  validation {
    condition     = contains(["pinned_client_certs", "pki_client_certs"], var.auth_type)
    error_message = "Allowed values are: pinned_client_certs or pki_client_certs."
  }
}

variable "cluster_type" {
  type        = string
  description = "The cluster type"
  default     = "CLUSTER_TYPE_CONTROL_PLANE"

  validation {
    condition     = contains(["CLUSTER_TYPE_CONTROL_PLANE", "CLUSTER_TYPE_K8S_INGRESS_CONTROLLER", "CLUSTER_TYPE_CONTROL_PLANE_GROUP", "CLUSTER_TYPE_HYBRID"], var.cluster_type)
    error_message = "Allowed values are: CLUSTER_TYPE_CONTROL_PLANE, CLUSTER_TYPE_K8S_INGRESS_CONTROLLER, CLUSTER_TYPE_CONTROL_PLANE_GROUP or CLUSTER_TYPE_HYBRID."
  }
}

/**
* Variables for MTLS certificate
 */
variable "tls_common_name" {
  type        = string
  description = "TLS Common Name"
  default     = "kong_clustering"
}

variable "tls_validity_period_hours" {
  type        = number
  description = "The certificate validity period in hours"
  default     = 26280 //1095 * 24 = 26280 hours == 1095 days
}

variable "tls_allowed_uses" {
  type        = list(string)
  description = "Key usages / extended key usages for the Kong cluster mTLS cert."
  default     = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}

/**
* Variables for private key
 */
variable "key_algorithm" {
  description = "Private key algorithm: RSA, ECDSA, or ED25519."
  type        = string
  default     = "ECDSA"

  validation {
    condition     = contains(["RSA", "ECDSA", "ED25519"], upper(var.key_algorithm))
    error_message = "key_algorithm must be one of: RSA, ECDSA, ED25519."
  }
}

variable "rsa_bits" {
  description = "RSA key size in bits. Only used when key_algorithm = RSA."
  type        = number
  default     = 2048

  validation {
    condition     = var.rsa_bits >= 2048 && var.rsa_bits <= 8192
    error_message = "rsa_bits should be a sane RSA size (e.g., 2048–8192)."
  }
}

variable "ecdsa_curve" {
  description = "ECDSA curve. Only used when key_algorithm = ECDSA."
  type        = string
  default     = "P384"

  validation {
    condition     = contains(["P224", "P256", "P384", "P521"], upper(var.ecdsa_curve))
    error_message = "ecdsa_curve must be one of: P224, P256, P384, P521."
  }
}

/**
* Kong helm chart
*/
variable "kubeconfig_path" {
  type        = string
  description = "Location of kubeconfig"
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  type        = string
  description = "Kubeconfig context"
  default     = "kind-kind"
}

variable "kong_namespace" {
  type        = string
  description = "Kong namespace"
  default     = "kong-demo"
}

variable "kong_chart_version" {
  type        = string
  description = "Kong chart version"
  default     = "2.52.0"
}

variable "kong_docker_repo" {
  type        = string
  description = "Kong DockerHub Repo"
  default     = "kong/kong-gateway"
}

variable "kong_gateway_version" {
  type        = string
  description = "Kong Gateway Version"
  default     = "3.13.0.0"
}

variable "proxy_service_type" {
  type        = string
  description = "Service type for the proxy service"
  default     = "LoadBalancer"
}

variable "apply_kong_config" {
  type        = bool
  description = "Toggle to apply Kong gateway config"
  default     = true
}
