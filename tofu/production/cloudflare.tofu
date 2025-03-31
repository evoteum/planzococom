locals {
  record_comment = "No traffic needed. Required so Cloudflare will apply the redirect rule. BECAUSE REASONS."

}

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
  ttl     = 1

  comment = local.record_comment

}

resource "cloudflare_dns_record" "www_redirect" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = "192.0.2.1"
  proxied = true
  ttl     = 1

  comment = local.record_comment
}
