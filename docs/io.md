## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_resolver\_inbound\_endpoints | (Optional): Set of Azure Private DNS resolver Inbound Endpoints | <pre>set(object({<br>    inbound_endpoint_name        = string<br>    private_ip_allocation_method = optional(string, "Dynamic")<br>    inbound_subnet_id            = string<br>    private_ip_address           = optional(string)<br><br>  }))</pre> | `[]` | no |
| dns\_resolver\_outbound\_endpoints | (Optional): Set of Azure Private DNS resolver Outbound Endpoints with one or more Forwarding Rule sets | <pre>set(object({<br>    outbound_endpoint_name = string<br>    outbound_subnet_id     = string<br>    forwarding_rulesets = optional(set(object({<br>      forwarding_ruleset_name = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| enable | Flag to control the module creation | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `null` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `null` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-azure-private-dns-resolver"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `null` | no |
| virtual\_network\_id | The name of the virtual network in which the subnet is created in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_resolver | n/a |

