resource "cloudflare_ruleset" "redirect_to_planzo" {
  zone_id     = var.cloudflare_zone_id
  name        = "redirect-to-planzo"
  description = "Redirect all traffic to ${var.target_url}"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules = [
    {
      ref         = "redirect_to_planzo"
      description = "Redirect all traffic to ${var.target_url}"
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
