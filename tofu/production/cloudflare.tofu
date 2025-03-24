resource "cloudflare_ruleset" "redirect_to_planzo" {
  zone_id     = data.cloudflare_zone.example_zone.id
  name        = "redirect-to-planzo-co"
  description = "Redirect all traffic to planzo.co"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    ref         = "redirect_to_planzo"
    description = "Redirect all traffic to planzo.co"
    expression  = "true"
    action      = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "https://planzo.co"
        }
        preserve_query_string = false
      }
    }
  }
}
