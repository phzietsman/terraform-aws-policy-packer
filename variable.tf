variable policy_type {
      type        = string
  description = "(Optional) Choose the type of policy that you want to generate.\n\nOptions: \"managed\", \"scp\", \"custom\"."
  default     = "managed"

  validation {
    condition = can(index([
      "managed",
      "scp",
      "custom"
    ], var.policy_type))
    error_message = "Invalid policy_type variable value."
  }
}

variable custom_policy_lenght {
    type = number
    description = ""
    default = 0
}

variable policy_version {
    default = "2012-10-17"
}

variable policy_statements {
    type = map(string)
    description = ""
}