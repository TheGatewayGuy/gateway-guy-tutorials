locals {
  algorithm = upper(var.key_algorithm)
}

resource "tls_private_key" "cluster" {
  algorithm   = local.algorithm

  rsa_bits    = local.algorithm == "RSA"   ? var.rsa_bits   : null
  ecdsa_curve = local.algorithm == "ECDSA" ? upper(var.ecdsa_curve) : null
}

resource "tls_self_signed_cert" "cluster" {
  private_key_pem = tls_private_key.cluster.private_key_pem

  subject {
    common_name = var.tls_common_name
  }

  validity_period_hours = var.tls_validity_period_hours

  allowed_uses = var.tls_allowed_uses
}