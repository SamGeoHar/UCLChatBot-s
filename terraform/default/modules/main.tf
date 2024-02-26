# this is the main deployment modules
# this should marshall all dependent module (plus any extra bits of glue)
# propogate the basic deploy name, environment, version, unique_name details 
# and add in any specific config needed for child modules

module "s3" {
  source = "git@github.com:ucl-isd/easikit-terraform-s3.git//module?ref=ccaedar/f/website_config"

  # propogated from the terraform.tfvars.json config element
  bucket_name         = local.config.bucket_name
  build_path               = "../../../../ChatBotApp/build"

  # core variables, from variables.tf, always just here
  name        = var.name
  serv        = var.serv
  env         = var.env
  vrsn        = var.vrsn
}



module "cloudfront" {
  source                  = "git@github.com:ucl-isd/easikit-terraform-cloudfront.git//module"
  bucket_domain           = module.s3.regional_domain

  bucket_id               = module.s3.s3_bucket_id
  bucket_arn              = module.s3.s3_bucket_arn
  # domain_name             = "catalogue.mesh-uat.ucl.ac.uk" # domain name optional

  # core variables, from variables.tf
  name                    = var.name
  env                     = var.env
  vrsn                    = var.vrsn
  serv                    = var.serv
}
