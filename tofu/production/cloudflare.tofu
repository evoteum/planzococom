resource "cloudflare_ruleset" "redirect_all" {
  zone_id     = var.cloudflare_zone_id
  name        = "redirect-all"
  description = "Redirect all traffic to ${var.target_url}"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules = [
    {
      ref         = "redirect_all"
      description = "Redirect everything to apex domain"
      expression  = "true"
      action      = "redirect"
      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = var.target_url
          }
          preserve_query_string = false
        }
      }
    }
  ]
}
resource "cloudflare_dns_record" "apex_redirect" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "A"
  content = "192.0.2.1"
  proxied = true
  ttl     = 3600

  comment = <<EOT
This record exists solely to placate Cloudflare’s requirement that proxied DNS records must be present for redirect rules to function — even when no origin is required. The target IP (192.0.2.1) is a non-routable test IP because we do not want Cloudflare to send traffic anywhere. This is a workaround for what should be a native “redirect-only zone” feature. It is, frankly, a daft requirement.
EOT
}

resource "cloudflare_dns_record" "www_redirect" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = "192.0.2.1"
  proxied = true
  ttl     = 3600

  comment = <<EOT
Same as the apex record: required only so Cloudflare will honour the redirect rules. This record serves no functional DNS purpose and exists to satisfy infrastructure that really should not need this kind of trickery.
EOT
}