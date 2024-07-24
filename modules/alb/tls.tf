data "aws_acm_certificate" "nemorluther-cert" {
  domain   = "*.nemorluther.fr"
  statuses = ["ISSUED"]
}