data "cloudflare_zone" "example_zone" {
  filter {
    name = local.domain
  }
}