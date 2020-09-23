locals {

    policy_path = "${path.module}/policies/"

    template_file_names = fileset(local.policy_path, "scp*.json")
    
    template_files_content = {
        for key, value in local.template_file_names:
            replace(key, ".json", "") => templatefile("${local.policy_path}/${value}", {})
     } 

    calcs = length(module.scp_packing.result)

}

module scp_packing {

    source = "../../"

    policy_type = "managed"

    policy_statements = local.template_files_content
    
}

# output raw {
#   value = module.scp_packing.raw
# }

output result_map {
  value = module.scp_packing.result_map
}

output calcs {
  value = local.calcs
}