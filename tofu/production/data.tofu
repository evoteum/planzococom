data "cloudflare_zone" "example_zone" {
  name = local.domain
}