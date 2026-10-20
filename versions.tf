terraform {
  required_version = "~> 1.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.8"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.3"
    }
  }
  # backend "local" {
  #   path = "tfstate/terraform.tfstate"
  # }

  backend "azurerm" {
    resource_group_name  = local.rg.common
    storage_account_name = local.common.st_tfs
    container_name       = "tfstate"
    key                  = "${local.year}/${var.project}/terrraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  storage_use_azuread = true
  features {
    key_vault {
      # tylko na potrzeby wczesnego developmentu/testów — usunąć później
      purge_soft_deleted_keys_on_destroy = true
      recover_soft_deleted_keys          = true
    }
  }
}
