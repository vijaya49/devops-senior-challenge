output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs_fargate.ecs_cluster_name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = module.ecs_fargate.ecs_service_name
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = module.ecs_fargate.alb_dns_name
}

output "target_group_blue_arn" {
  description = "Blue Target Group ARN"
  value       = module.ecs_fargate.target_group_blue_arn
}

output "target_group_green_arn" {
  description = "Green Target Group ARN"
  value       = module.ecs_fargate.target_group_green_arn
}

output "ecr_repo_url" {
  description = "ECR Repo URL"
  value       = module.ecs_fargate.ecr_repo_url
}
