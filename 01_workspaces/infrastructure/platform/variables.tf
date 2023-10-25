variable "asg_instance_type" {
    type = string
    description = <<-EOT
        EC2 Instance type.
    EOT
}

variable "asg_max_instances" {
    type = number
    description = <<-EOT
        Maximum number of instances in the autoscaling group.
    EOT
}

variable "availability_zones" {
    type = list(string)
    description = <<-EOT
        AWS availability zones.
    EOT
}

variable "domain_name" {
    type = string
    description = <<-EOT
        This DNS zone must exist in route 53 in the same AWS account.
    EOT
}