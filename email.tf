resource "aws_route53_record" "email_mx" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "MX"
  ttl     = 300
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
}

// mail.intimitrons.ca is currently in use by mail clients
resource "aws_route53_record" "email_mail" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "mail"
  type    = "A"
  ttl     = 3600
  records = ["198.20.92.28"]
}

// webmail.intimitrons.ca accesses the web client
// Likely unused by most on the team but maintained for now to ensure there is always a way to access email
resource "aws_route53_record" "email_webmail" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "webmail"
  type    = "A"
  ttl     = 3600
  records = ["198.20.92.28"]
}

resource "aws_route53_record" "email_spf" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 include:_spf.google.com ~all"]
}
