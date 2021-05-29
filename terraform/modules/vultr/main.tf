variable "vultr_api_key" {
    type = string
}

provider "vultr" {
  api_key = var.vultr_api_key
  rate_limit = 700
  retry_limit = 3
}

terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.3.0"
    }
  }
}



# Create a web instance
resource "vultr_instance" "web" {
  # ...
}