data "cloudflare_zone" "example_zone" {
  name = locals.domain
}