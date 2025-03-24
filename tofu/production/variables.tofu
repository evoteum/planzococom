variable "homepage_url" {
  description = "The web address of publicly available application"
  type        = string
}

variable "target_url" {
  description = "The URL to redirect all traffic to"
  type        = string
  default     = "https://planzo.co"
}