resource "aws_route53_record" "email_mx" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "MX"
  ttl     = 86400
  records = ["10 mail.intimitrons.ca."]
}

// mail.intimitrons.ca is currently in use by mail clients
resource "aws_route53_record" "email_mail" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "mail"
  type    = "A"
  ttl     = 86400
  records = ["198.20.92.28"]
}

// webmail.intimitrons.ca accesses the web client
// Likely unused by most on the team but maintained for now to ensure there is always a way to access email
resource "aws_route53_record" "email_webmail" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "webmail"
  type    = "A"
  ttl     = 86400
  records = ["198.20.92.28"]
}

resource "aws_route53_record" "email_spf" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 86400
  records = ["v=spf1 +a +mx +ip4:198.20.71.150 include:reliablemail.org ~all"]
}

// Private key can be retrieved from cPanel
resource "aws_route53_record" "email_dkim" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "default._domainkey"
  type    = "TXT"
  ttl     = 86400
  records = ["v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt+kTk4ZC6BsWlCxjQMWLAHhgMMpRZFpi6igFZsdoq+Tyw+rhP4RU6sztlVLwss77HmDeTE1oVctYwXqd9kHTixKFWqrQwJB3rTNPyQ9+xXNqvcMKhPN990ORVAWhkAf/wGy6ez0BW3cunBI/sa4ZhCOuzahVSwKL0zKzTy/d9OVH/RaADuajiXkESIxIxZHm8\"\"2EKuI4xnqyfqrg2DTiqzDAsLz8f8/x20DjubgKLZUnAsVdK/oySDY8S0WYi/gMX+kI8m9hQye1qC88iBPZHH57JwHVbxBIhIGhug6SUj3KS2gtVAOGmxszQbo6aEnGDpEow1mE9qYBiz2DqZZSU4QIDAQAB;"]
}
