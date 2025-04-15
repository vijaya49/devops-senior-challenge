resource "aws_ecr_repository" "simpletimeservice" {
  name = lower(var.app_name)

  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
