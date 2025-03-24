data "cloudflare_zone" "this" {
  filter {
    name    = local.domain
    status  = "active"
    paused  = false
    account = var.cloudflare_account_id
  }
}