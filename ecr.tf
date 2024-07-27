# 프론트엔드 ECR 리포지토리 데이터 소스
data "aws_ecr_repository" "ori_frontend" {
  name = "frontend-app"
}

# 백엔드 ECR 리포지토리 데이터 소스
data "aws_ecr_repository" "ori_backend" {
  name = "backend-app"
}
