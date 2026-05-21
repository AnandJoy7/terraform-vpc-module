
# -----------------------------------------------------------------------------
# VPC Module Outputs
# -----------------------------------------------------------------------------

output "vpc_id" {
  description = "The ID of the provisioned VPC"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "The ARN of the provisioned VPC"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway (empty string if not created)"
  value       = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : ""
}

output "public_subnet_ids" {
  description = "Map of public subnet name to subnet ID"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "public_subnet_cidrs" {
  description = "Map of public subnet name to CIDR block"
  value       = { for k, v in aws_subnet.public : k => v.cidr_block }
}

output "private_subnet_ids" {
  description = "Map of private subnet name to subnet ID"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "private_subnet_cidrs" {
  description = "Map of private subnet name to CIDR block"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}

output "nat_gateway_ids" {
  description = "Map of public subnet name to NAT Gateway ID (only for subnets with create_nat_gateway=true)"
  value       = { for k, v in aws_nat_gateway.this : k => v.id }
}

output "nat_gateway_public_ips" {
  description = "Map of public subnet name to NAT Gateway public Elastic IP"
  value       = { for k, v in aws_eip.nat : k => v.public_ip }
}

output "public_route_table_id" {
  description = "The ID of the shared public route table"
  value       = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : ""
}

output "private_route_table_ids" {
  description = "Map of private subnet name to its dedicated route table ID"
  value       = { for k, v in aws_route_table.private : k => v.id }
}

output "flow_log_id" {
  description = "The ID of the VPC Flow Log (empty string if flow logs are disabled)"
  value       = length(aws_flow_log.this) > 0 ? aws_flow_log.this[0].id : ""
}

output "flow_log_cloudwatch_log_group" {
  description = "The CloudWatch Log Group name for VPC Flow Logs"
  value       = length(aws_cloudwatch_log_group.flow_logs) > 0 ? aws_cloudwatch_log_group.flow_logs[0].name : ""
}
