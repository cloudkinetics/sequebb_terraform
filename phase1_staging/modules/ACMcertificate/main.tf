##Creating tls certificate
resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.rsa-4096-example.private_key_pem
  subject {
    common_name  = var.common_name
    organization = "ACME Examples, Inc"
  }
  validity_period_hours = 8760
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096-example" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}
##creating ACM certificate
resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.rsa-4096-example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
  #validation_method = "DNS"
}