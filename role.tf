resource "aws_iam_role" "autoscaling_role" {
  name = "AutoScalingRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "autoscaling.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "autoscaling_policy" {
  role       = aws_iam_role.autoscaling_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "autoscaling_profile" {
  name = "autoscaling-profile"
}
