# variable "zone_id" {
#   description = "waitmate 호스팅 영역 id"
#   default     = "Z01237701HV241SU3ZQJK"
# }

resource "aws_route53_record" "ori_route53" {
  zone_id = "Z01237701HV241SU3ZQJK"  # Route 53 호스팅 영역 ID
  name    = "waitmate.shop"  # 도메인 이름
  type    = "A"  # 레코드 타입

  alias {
    name                   = aws_lb.ori-lb.dns_name  # ALB의 DNS 이름
    zone_id                = aws_lb.ori-lb.zone_id   # ALB의 Zone ID
    evaluate_target_health = true  # 헬스 체크 활성화
  }
}

# ACM에서 발급받은 SSL 인증서 ARN
variable "ssl_certificate_arn" {
  description = "arn:aws:acm:ap-northeast-2:381492295588:certificate/86ea57c1-9134-444d-b3ea-9d5e55d10104"
  type        = string
}