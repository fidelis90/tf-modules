terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
# does not work on Tony's m2.
#brew uninstall terraform
#brew install tfenv
#TFENV_ARCH=amd64 tfenv install 1.3.3
#tfenv use 1.3.3
##    │ Error: Incompatible provider version
##    │ Provider registry.terraform.io/hashicorp/helm v2.0.1 does not have a package available for your current platform, darwin_arm64.
##    │ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have different platforms supported.
    /* helm = {
      source  = "hashicorp/helm"
      version = "2.0.1"
    }
##    │ Error: Incompatible provider version
##    │ Provider registry.terraform.io/gitlabhq/gitlab v3.3.0 does not have a package available for your current platform, darwin_arm64.
##    │ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have different platforms supported.
    gitlab = {
      source  = "registry.terraform.io/gitlabhq/gitlab"
      version = "3.3.0"
    } */
  }
}

provider "azurerm" {
  features {}
}