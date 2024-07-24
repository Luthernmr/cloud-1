resource "aws_iam_server_certificate" "ft_cert" {
  # Terraform's documentation recommends the use of `name_prefix`
  # with `create_before_destroy` to better manage it while in use
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_server_certificate
  name_prefix     = "certificate_ssl"
  lifecycle {
    create_before_destroy = true
  }

  certificate_body = file("certificates/nemorluther.pem")
  private_key      = file("certificates/nemorluther.key")
}
