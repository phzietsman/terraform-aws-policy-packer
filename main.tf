locals {
  character_limits = {
    managed = 6144,
    scp = 5120,
    custom = var.custom_policy_lenght
  }

  policy_body_empty = templatefile("${path.module}/policy-body.tmpl", {
    policy_version = var.policy_version
    statement_content = ""
  })

  policies_built_decoded = [ 
    for _, collections in data.javascript.algorithm.result:
      jsondecode(templatefile("${path.module}/policy-body.tmpl", {
        policy_version = var.policy_version
        statement_content = join(",\n", [ for _, statements in collections["collection"]: statements["statement"]]) 
      }))
  ]
}



data "javascript" "algorithm" {
  source = file("${path.module}/first-fit-decreasing.js")

  vars = {
      INPUT_COLLECTION = var.policy_statements
      INPUT_BIN_SIZE = local.character_limits[var.policy_type] - length(local.policy_body_empty) // Get the usuable charecter count
  }
}