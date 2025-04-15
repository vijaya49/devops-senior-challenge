module "ecs_fargate" {
  source              = "./ecs-fargate"
  app_name            = "SimpleTimeService"
  region              = "us-east-1"
  vpc_id              = "vpc-0220d21cced9787fa"
  subnet_ids          = ["subnet-08f68626e7f35fd7f", "subnet-0c71a3a2a61985487"]
  domain_name         = "simple-time-service.cloudvj.xyz"
  hosted_zone_id      = "Z02038983P10ZA17B5SN8"
  container_port      = 80
}
