# EC2 Instance
resource "aws_instance" "datacenter_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "datacenter-ec2"
  }
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "datacenter_alarm" {
  alarm_name          = "datacenter-alarm"
  alarm_description   = "Alarm when CPU exceeds 90% for 5 minutes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  actions_enabled     = true

  # Reference the existing SNS topic ARN directly
  alarm_actions = ["arn:aws:sns:us-east-1:226175311211:datacenter-sns-topic"]

  dimensions = {
    InstanceId = aws_instance.datacenter_ec2.id
  }

  tags = {
    Name = "datacenter-alarm"
  }
}
