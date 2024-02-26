# ------------------------ #
# ------- secrets -------- #
# ------------------------ #

# below decrypts all the secrets for this target
# all these passwords will have been encrypted by the same
# vault password file as specified in the provider
# if you used z deploy secret to initialise them, that should
# already be set to ..../secrets/vault-pass.txt

# once created, be sure to reference this password in the locals block
# in the main easikit.tf file
# data "ansiblevault_path" "db_password" {
#   path = "secrets/DB_PASSWORD"
# }


# once added above, reference them below so they are merged in with the tfvars
# in the appropriate place - either in config, or in env_vars as approps
# if using the secrets module (as you should) you will probs only need config_secrets
locals {
  config_secrets = {
    #password = sensitive(data.ansiblevault_path.password.value)
  }

  env_secrets = {
    #DB_PASSWORD = sensitive(data.ansiblevault_path.db_password.value)
  }
}