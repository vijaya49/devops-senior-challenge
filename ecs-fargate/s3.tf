# resource "aws_s3_bucket" "codepipeline_bucket" {
#   bucket = "simpletimeservice-codepipeline-artifacts-${random_id.suffix.hex}"
#   force_destroy = true
# }

# resource "random_id" "suffix" {
#   byte_length = 4
# }
