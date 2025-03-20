output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "azs" {
  value = data.aws_availability_zones.available.names
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}