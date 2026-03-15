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

variable "email_api_key" {
  description = "Email service API key for sending notifications"
  sensitive = true
}

variable "email_api_endpoint" {
  description = "URL for the hosted email API"
}
