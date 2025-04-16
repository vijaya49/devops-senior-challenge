#New Infra Provisioning
module "ecs_fargate" {
  source              = "./ecs-fargate"
  app_name            = "SimpTimeServ-new"
  region              = "us-east-1"
  domain_name         = "simpleTimeService.cloudvj.xyz"
  hosted_zone_id      = "Z02038983P10ZA17B5SN8"
  container_port      = 80
  image_tag = var.image_tag
}
