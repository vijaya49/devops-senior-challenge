variable "image_tag" {
  description = "Tag of the Docker image to deploy"
  type        = string
  default     = "latest" # optional, but helps for validation
}
