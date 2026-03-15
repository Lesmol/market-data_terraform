resource "aws_ecr_repository" "market_data" {
  name                 = "market-data"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}