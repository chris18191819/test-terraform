variable "environment" { type = string }
variable "cluster_version" { type = string default = "1.30" }
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "node_min_size" { type = number }
variable "node_max_size" { type = number }
variable "node_desired_size" { type = number }
variable "instance_types" { type = list(string) }
