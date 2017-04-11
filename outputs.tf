## Outputs for reference

output "The Rancher Server URL is" {
  value = "https://${var.env_name}.${var.dns_zone}"
}
