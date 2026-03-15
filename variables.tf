variable "region" {
  description = "AWS Region"
}

variable "tag" {
  description = "Project tag"
}

variable "polygon_api_key" {
  description = "Polygon API key for market data access"
  sensitive = true
}

variable "email_service_api_key" {
  description = "Email service API key for sending notifications"
  sensitive = true
}

variable "hosted_email_api_url" {
  description = "URL for the hosted email API"
}
