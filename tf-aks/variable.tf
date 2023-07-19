variable "deployment_settings" {
  type = object({
    region = string 
  })
}

variable "agents_count" {
  type = number
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "client_id" {
  default = null
}

variable "client_secret" {
  default = null
}

variable "resource_group_name" {}

variable "cluster_name" {}

variable "dns_prefix" {}

variable "location" {
  type = string
  default = null
}

variable "log_analytics_workspace_name" {}

# Refer to https://azure.microsoft.com/pricing/details/monitor/ for Log Analytics pricing
variable "log_analytics_workspace_sku" {}

variable "agents_size" { 
  default = "Standard_D4_v3"
}

variable "agents_pool_name" { 
  default =  "agentpool"
}

variable "enable_auto_scaling" {
  type = bool
  default = false
}

variable "aks_cluster_resource_tags" {
  type = map(string)
  default = {}
}

variable "ssh_public_key" {}

variable "admin_username" {
  type = bool
  default = true
}

#variable "acr_name" {
#  default = ""
#}

variable "gitlab_url" {
  default = "https://gitlab.com"
}

variable gitlab_agent_token {
  default = "" # Gitlab agent token is the token created in https://docs.gitlab.com/ee/user/clusters/agent/install/#register-the-agent-with-gitlab
}

#variable "gitlab_access_token" {
#  default = "" # set in https://gitlab.com/-/profile/personal_access_tokens?name=DevOpsGitLabAccessToken&scopes=api,read_user,read_registry
#}

# https://gitlab.com/pgforsta/pg-fusion/uam/hxdashboard From Dan
variable "gitlab_project_id" {
  default = "44898187"
}
# repo-name -> https://gitlab.com/pgforsta/pg-fusion/uam/hxdashboard

# networking 
variable "network_plugin" {
  default = "kubenet"
}

variable "subnet_cidr" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_cidr" {
  type = list(string)
}