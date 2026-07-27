variable "secret_name" {}

variable "secret_value" {}

variable "oidc_provider_arn" {}

variable "oidc_provider" {}

variable "namespace" {

 default = "weather"

}

variable "service_account_name" {
  type = string
}
