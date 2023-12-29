variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {
    app         = "wordpress",
    environment = "prod"
  }
}

variable "env" {
  description = "Name of the application environment. e.g. dev, prd, stg"
  type        = string
  default     = "prd"
}

variable "prefix" {
  description = "Prefix for all the resources to be created. Please note thst 2 allows only lowercase alphanumeric characters and hyphen"
  default     = "wordpress"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = set(string)
  default     = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = <<EOF
    List of CIDR blocks for private subnets. The number of subnets can't exceed the number of availability zones
  EOF

  type    = set(string)
  default = [
    "10.0.100.0/24",
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}

variable "database_subnet_cidrs" {
  description = "List of CIDR blocks for db subnets"
  type        = set(string)
  default     = [
    "10.0.200.0/24",
    "10.0.201.0/24",
    "10.0.202.0/24"
  ]
}

variable "domain_name" {
  description = "Domain name without www"
  type        = string
  default     = "madwithpower.net"
}

variable "domain_auto_renew" {
  description = "Whether or not you want the domain to auto-renew"
  type        = bool
  default     = false
}
#
variable "asg_instance_type" {
  description = "AutoScaling Group Instance type"
  default     = "t3.micro"
}
variable "asg_launch_template_description" {
  description = "AutoScaling Group launch template description"
  default     = "Wordpress Launch Template"
}

variable "asg_min_size" {
  description = "AutoScaling Group Min Size "
  default     = 1
}

variable "asg_max_size" {
  description = "AutoScaling Group Max Size "
  default     = 2
}

variable "asg_desired_capacity" {
  description = "AutoScaling Group Desired Capacity"
  default     = 1
}

variable "rds_engine" {
  description = "RDS engine"
  default     = "mariadb"
}

variable "rds_engine_major_version" {
  description = "RDS engine version"
  default     = "10.11"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the db for wordpress"
  default     = "wordpressdb"
}
#
#variable "site_domain" {
#  description = "Domain"
#  default     = "example.com"
#}
#
#variable "cloudflare_zone" {
#  description = "cloudflare Zone Id"
#}
#
#variable "dns_ttl" {
#  description = "cloudflare for dns = 1 is automatic."
#  default     = 1
#}
#
#variable "dns_allow_overwrite_records" {
#  description = "cloudflare allow overwrite records."
#  default     = true
#}
#
#variable "cloudflare_api_token" {
#  description = "cloudflare api token"
#}
#
variable "ssh_key_name" {
  description = "SSH Key"
  default     = "wp-asg-key"
}
