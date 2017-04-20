## IAM EC2 policy + role + profile

resource "aws_iam_role_policy" "rancher" {
  name = "rancher"
  role = "${aws_iam_role.rancher.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect":"Allow",
        "Action":[
          "ec2:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "route53:*",
          "s3:*",
          "sns:*",
          "cloudwatch:*"
        ],
        "Resource":"*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "rancher" {
  name = "rancher"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "rancher" {
  name  = "rancher"
  roles = ["${aws_iam_role.rancher.name}"]
}
