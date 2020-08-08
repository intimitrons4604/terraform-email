resource "aws_ses_domain_identity" "main" {
  domain = trimsuffix(data.terraform_remote_state.dns.outputs.fqdn, ".")
}

resource "aws_route53_record" "aws_ses_verification" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "_amazonses"
  type    = "TXT"
  ttl     = 1800
  records = ["${aws_ses_domain_identity.main.verification_token}"]
}

resource "aws_ses_domain_identity_verification" "main" {
  domain = aws_ses_domain_identity.main.domain

  depends_on = [aws_route53_record.aws_ses_verification]
}
