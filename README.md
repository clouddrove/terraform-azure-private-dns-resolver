<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AZURE PRIVATE DNS RESOLVER


</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create Private DNS Resolver resource on AZURE.
     </p>

<p align="center">

<a href="https://github.com/clouddrove/terraform-azure-private-dns-resolver/releases/latest">
  <img src="https://img.shields.io/github/release/clouddrove/terraform-azure-private-dns-resolver.svg" alt="Latest Release">
</a>
<a href="https://github.com/clouddrove/terraform-azure-private-dns-resolver/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-azure-private-dns-resolver/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-azure-private-dns-resolver'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AZURE+PRIVATE+DNS+RESOLVER&url=https://github.com/clouddrove/terraform-azure-private-dns-resolver'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AZURE+PRIVATE+DNS+RESOLVER&url=https://github.com/clouddrove/terraform-azure-private-dns-resolver'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 






## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-azure-private-dns-resolver/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
### private-dns-resolver
```hcl
  module "dns-private-resolver" {
    source              = "../.."
    name                = local.name
    environment         = local.environment
    resource_group_name = module.resource_group.resource_group_name
    location            = module.resource_group.resource_group_location

    virtual_network_id = module.vnet.vnet_id
    dns_resolver_inbound_endpoints = [
      # There is currently only support for two Inbound endpoints per Private Resolver.
      {
        inbound_endpoint_name = "inbound"
        inbound_subnet_id     = module.subnet.default_subnet_id[0]
      }
    ]
  }
```






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




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-azure-private-dns-resolver/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-azure-private-dns-resolver)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
