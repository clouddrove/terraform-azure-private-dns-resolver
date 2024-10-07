#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = null
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-azure-private-dns-resolver"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "enable" {
  type        = bool
  default     = true
  description = "Flag to control the module creation"
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  default     = null
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "virtual_network_id" {
  type        = string
  default     = null
  description = "The name of the virtual network in which the subnet is created in"
}

variable "dns_resolver_inbound_endpoints" {
  type = set(object({
    inbound_endpoint_name        = string
    private_ip_allocation_method = optional(string, "Dynamic")
    inbound_subnet_id            = string
    private_ip_address           = optional(string)

  }))
  default     = []
  description = "(Optional): Set of Azure Private DNS resolver Inbound Endpoints"

}

variable "dns_resolver_outbound_endpoints" {
  type = set(object({
    outbound_endpoint_name = string
    outbound_subnet_id     = string
    forwarding_rulesets = optional(set(object({
      forwarding_ruleset_name = optional(string)
    })))
  }))
  default     = []
  description = "(Optional): Set of Azure Private DNS resolver Outbound Endpoints with one or more Forwarding Rule sets"

}
