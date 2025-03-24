locals {
    domain = regex("^https?://([^/]+)", var.homepage_url)[0]
}