terraform {
  required_version = ">= 0.13.0"

  required_providers {
    javascript = {
      source = "cloudandthings/javascript"
      version = "0.0.2"
    }

    validation = {
      source = "tlkamp/validation"
      version = "1.0.0"
    }
  }
}
