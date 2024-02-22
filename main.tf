##-----------------------------------------------------------------------------
## Locals declaration 
##-----------------------------------------------------------------------------
locals {
  inbound_endpoint_map  = { for inboundendpoint in var.dns_resolver_inbound_endpoints : inboundendpoint.inbound_endpoint_name => inboundendpoint }
  outbound_endpoint_map = { for outboundendpoint in var.dns_resolver_outbound_endpoints : outboundendpoint.outbound_endpoint_name => outboundendpoint }

  outbound_endpoint_forwarding_rule_sets = flatten([
    for outbound_endpoint_key, outboundendpoint in var.dns_resolver_outbound_endpoints : [
      for forwarding_rule_set_key, forwardingruleset in outboundendpoint.forwarding_rulesets : {
        outbound_endpoint_name  = outboundendpoint.outbound_endpoint_name
        forwarding_ruleset_name = forwardingruleset.forwarding_ruleset_name
        outbound_endpoint_id    = azurerm_private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint[outbound_endpoint_key.outbound_endpoint_name].id
      }
    ]
  ])
}

##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
  extra_tags  = var.extra_tags
}

##-----------------------------------------------------------------------------
## Below resource will deploy Private DNS resolver in your azure environment.
##-----------------------------------------------------------------------------
resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  count               = var.enable ? 1 : 0
  name                = format("%s-pvt-dns-resolver", module.labels.id)
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = module.labels.tags
}

# Creating one or multiple Inbound Endpoints based on input map, note there is currently only support for two inbound endpoints per DNS Resolver, and they cannot share the same subnet.
resource "azurerm_private_dns_resolver_inbound_endpoint" "private_dns_resolver_inbound_endpoint" {
  for_each                = var.enable ? local.inbound_endpoint_map : {}
  name                    = each.value.inbound_endpoint_name
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver[0].id
  location                = var.location
  tags                    = module.labels.tags

  ip_configurations {
    private_ip_allocation_method = each.value.private_ip_allocation_method # Dynamic is default and only supported.
    private_ip_address           = each.value.private_ip_address
    subnet_id                    = each.value.inbound_subnet_id
  }
}

# Creating one or multiple Outbound Endpoints based on input map, note there is currently only support for two outbound endpoints per DNS Resolver, and they cannot share the same subnet.
resource "azurerm_private_dns_resolver_outbound_endpoint" "private_dns_resolver_outbound_endpoint" {
  for_each                = var.enable ? local.outbound_endpoint_map : {}
  name                    = each.value.outbound_endpoint_name
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver[0].id
  location                = var.location
  subnet_id               = each.value.outbound_subnet_id
  tags                    = module.labels.tags
}

# Creating one or multiple DNS Resolver Forwarding rulesets, there is currently only support for two DNS forwarding rulesets per outbound endpoint
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "forwarding_ruleset" {
  for_each = var.enable ? {
    for forwarding_rule_set in local.outbound_endpoint_forwarding_rule_sets : "${forwarding_rule_set.outbound_endpoint_name}-${forwarding_rule_set.forwarding_ruleset_name}" => forwarding_rule_set
  } : {}
  name                                       = each.value.forwarding_ruleset_name
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [each.value.outbound_endpoint_id]
  tags                                       = module.labels.tags
}