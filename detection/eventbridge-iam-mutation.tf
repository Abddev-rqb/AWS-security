resource "aws_cloudwatch_event_bus" "security_bus" {
  name = "security-central-bus"
}

resource "aws_cloudwatch_event_bus_policy" "allow_org_accounts" {
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  policy = jsonencode({
    Statement = [
      {
        Sid       = "AllowOrgAccounts"
        Effect    = "Allow"
        Principal = "*"
        Action    = "events:PutEvents"
        Resource  = aws_cloudwatch_event_bus.security_bus.arn
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" = var.organization_id
          }
        }
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "iam_mutation_detection" {
  name           = "iam-mutation-detection"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  event_pattern = jsonencode({
    source      = ["aws.iam"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventName = [
        "CreateUser",
        "CreateAccessKey",
        "CreateRole",
        "AttachRolePolicy",
        "PutRolePolicy",
        "UpdateAssumeRolePolicy",
        "CreatePolicyVersion",
        "SetDefaultPolicyVersion",
        "DeleteTrail",
        "StopLogging",
        "DeleteAnalyzer",
        "DeleteRule",
        "DisableRule"
      ]
    }
  })
}

resource "aws_cloudwatch_event_rule" "root_activity_detection" {
  name           = "root-activity-detection"
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name

  event_pattern = jsonencode({
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      userIdentity = {
        type = ["Root"]
      }
    }
  })
}

resource "aws_sns_topic" "security_alerts" {
  name = "security-alerts"
}

resource "aws_cloudwatch_event_target" "iam_mutation_target" {
  rule           = aws_cloudwatch_event_rule.iam_mutation_detection.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name
  arn            = aws_sns_topic.security_alerts.arn
}

resource "aws_cloudwatch_event_target" "root_activity_target" {
  rule           = aws_cloudwatch_event_rule.root_activity_detection.name
  event_bus_name = aws_cloudwatch_event_bus.security_bus.name
  arn            = aws_sns_topic.security_alerts.arn
}

resource "aws_cloudwatch_event_rule" "forward_iam_events" {
  name = "forward-iam-events"

  event_pattern = jsonencode({
    source      = ["aws.iam"]
    detail-type = ["AWS API Call via CloudTrail"]
  })
}

resource "aws_cloudwatch_event_target" "forward_to_security_bus" {
  rule = aws_cloudwatch_event_rule.forward_iam_events.name
  arn  = var.security_event_bus_arn
}