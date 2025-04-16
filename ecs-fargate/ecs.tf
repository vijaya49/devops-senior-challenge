resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster"
}


resource "aws_ecs_task_definition" "task" {
  family                = "${var.app_name}-task"
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "256"
  memory                = "512"

  container_definitions = jsonencode([{
    name      = var.app_name
    image     = "${aws_ecr_repository.simpletimeservice.repository_url}:${var.image_tag}" # Use the dynamic image tag
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]
  }])

  depends_on = [aws_security_group.ecs_sg]
}





resource "aws_ecs_service" "service" {
  depends_on = [
  aws_vpc.main,
  aws_subnet.public[*],
  aws_subnet.private[*]
]

 # depends_on = [ aws_ecs_task_definition.task ]
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    #subnets         = var.subnet_ids
    subnets = [aws_subnet.private[0].id, aws_subnet.private[1].id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = var.app_name
    container_port   = var.container_port
  }
}
