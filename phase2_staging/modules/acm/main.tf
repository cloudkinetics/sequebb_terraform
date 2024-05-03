resource "tls_self_signed_cert" "certificate" {
  private_key_pem = tls_private_key.key.private_key_pem
  subject {
    common_name  = var.common_name
    organization = var.organization
  }
  validity_period_hours = var.validity_period_hours
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]


}
# RSA key of size 4096 bits
resource "tls_private_key" "key" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}
resource "aws_acm_certificate" "acm_certificate" {
  private_key      = tls_private_key.key.private_key_pem
  certificate_body = tls_self_signed_cert.certificate.cert_pem

  tags = {
    Environment = var.Environment
  }
}