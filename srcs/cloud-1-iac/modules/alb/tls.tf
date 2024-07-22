resource "aws_iam_server_certificate" "ft_cert" {
  name             = "certificate_ssl"
  certificate_body = file("${path.module}/../../environment/dev/certificates/nemorluther.pem")
  private_key      = file("${path.module}/../../environment/dev/certificates/nemorluther.key")
  lifecycle {
    create_before_destroy = true
  }
}
