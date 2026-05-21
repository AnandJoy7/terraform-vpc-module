
# -----------------------------------------------------------------------------
# VPC Module Variables
# -----------------------------------------------------------------------------

variable "vpc_name" {
  description = "Name tag to assign to the VPC and used as a prefix for related resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "Primary IPv4 CIDR block for the VPC (e.g. 10.20.0.0/16)"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "enable_dns_support" {
  description = "Enable DNS resolution support within the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for instances launched in the VPC"
  type        = bool
  default     = true
}

variable "create_igw" {
  description = "Whether to create an Internet Gateway. Set to false for fully private VPCs"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = <<-EOT
    List of public subnet definitions. Each object supports:
    - name                  (required) string  : Unique name for the subnet
    - cidr                  (required) string  : IPv4 CIDR block
    - availability_zone     (required) string  : AZ e.g. us-west-1a
    - description           (optional) string  : Human-readable description tag
    - map_public_ip_on_launch (optional) bool  : Auto-assign public IPs (default true)
    - create_nat_gateway    (optional) bool    : Create a NAT GW in this subnet (default false)
  EOT
  type = list(object({
    name                   = string
    cidr                   = string
    availability_zone      = string
    description            = optional(string, "")
    map_public_ip_on_launch = optional(bool, true)
    create_nat_gateway     = optional(bool, false)
  }))
  default = []
}

variable "private_subnets" {
  description = <<-EOT
    List of private subnet definitions. Each object supports:
    - name              (required) string : Unique name for the subnet
    - cidr              (required) string : IPv4 CIDR block
    - availability_zone (required) string : AZ e.g. us-west-1b
    - description       (optional) string : Human-readable description tag
    - tier              (optional) string : Logical tier label e.g. app, db (default: private)
    - nat_gateway_subnet (optional) string : Name of the public subnet whose NAT GW this subnet should route through
  EOT
  type = list(object({
    name               = string
    cidr               = string
    availability_zone  = string
    description        = optional(string, "")
    tier               = optional(string, "private")
    nat_gateway_subnet = optional(string, "")
  }))
  default = []
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch Logs for network traffic visibility"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Number of days to retain VPC Flow Log entries in CloudWatch"
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.flow_logs_retention_days)
    error_message = "flow_logs_retention_days must be a valid CloudWatch Logs retention value."
  }
}

variable "tags" {
  description = "Map of tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}
