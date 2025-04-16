#New Infra Provisioning
module "ecs_fargate" {
  source              = "./ecs-fargate"
  app_name            = "SimpTimeServ-new"
  region              = "us-east-1"
  domain_name         = "simpletimeservice.cloudvj.in"
  hosted_zone_id      = "Z03659932DLDYYQJTHLW"
  container_port      = 8080
  image_tag = var.image_tag
}
