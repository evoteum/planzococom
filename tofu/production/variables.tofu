variable "cloudflare_account_id" {
  description = "The cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "This cloudflare zone ID"
  type        = string
  sensitive   = true
}

variable "homepage_url" {
  description = "The web address of publicly available application"
  type        = string
}

variable "target_url" {
  description = "The URL to redirect all traffic to"
  type        = string
  default     = "https://planzo.co"
}
