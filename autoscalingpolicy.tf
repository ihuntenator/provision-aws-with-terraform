# scale up alarm

resource "aws_autoscaling_policy" "linux-worker-cpu-policy" {
  name                   = "linux-worker-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.dynamic-linux-worker-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "linux-worker-cpu-alarm" {
  alarm_name          = "linux-worker-cpu-alarm"
  alarm_description   = "linux-worker-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.dynamic-linux-worker-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.linux-worker-cpu-policy.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "linux-worker-cpu-policy-scaledown" {
  name                   = "linux-worker-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.dynamic-linux-worker-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "linux-worker-cpu-alarm-scaledown" {
  alarm_name          = "linux-worker-cpu-alarm-scaledown"
  alarm_description   = "linux-worker-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.dynamic-linux-worker-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.linux-worker-cpu-policy-scaledown.arn}"]
}

resource "aws_autoscaling_policy" "windows-worker-cpu-policy" {
  name                   = "windows-worker-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.dynamic-windows-worker-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "windows-worker-cpu-alarm" {
  alarm_name          = "windows-worker-cpu-alarm"
  alarm_description   = "windows-worker-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.dynamic-windows-worker-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.windows-worker-cpu-policy.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "windows-worker-cpu-policy-scaledown" {
  name                   = "windows-worker-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.dynamic-windows-worker-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "windows-worker-cpu-alarm-scaledown" {
  alarm_name          = "windows-worker-cpu-alarm-scaledown"
  alarm_description   = "windows-worker-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.dynamic-windows-worker-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.windows-worker-cpu-policy-scaledown.arn}"]
}

