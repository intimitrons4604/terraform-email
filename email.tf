resource "aws_route53_record" "email_mx" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "MX"
  ttl     = 86400
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
}

resource "aws_route53_record" "email_spf" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 86400
  records = ["v=spf1 include:_spf.google.com ~all"]
}
