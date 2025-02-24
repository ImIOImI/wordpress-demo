###############################################################
# Security Group
###############################################################

module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.prefix}-${var.env}-db-sg"
  description = "MySQL Security Group"
  vpc_id      = aws_vpc.this.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = aws_vpc.this.cidr_block
    },
  ]
  tags = local.tags
}

module "efs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.prefix}-${var.env}-efs-sg"
  description = "EFS Security Group"
  vpc_id      = aws_vpc.this.id

  # ingress
  ingress_cidr_blocks = [aws_vpc.this.cidr_block]
  ingress_rules       = ["all-all"]

  tags = local.tags
}

module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.prefix}-${var.env}-ssh-sg"
  description = "SSH Security Group"
  vpc_id      = aws_vpc.this.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      description = "SSH access from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "Acess from within VPC"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = aws_vpc.this.cidr_block
    },
  ]

  # egress
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.tags
}

module "http_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.prefix}-${var.env}-http-sg"
  description = "Frontend Security Group"
  vpc_id      = aws_vpc.this.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "${var.env}-https to ELB"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "${var.env}-http to ELB"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ##### egress
  egress_with_cidr_blocks = [
    {
      description = "Access from within VPC"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = aws_vpc.this.cidr_block
    },
  ]

  tags = local.tags
}
