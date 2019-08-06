variable "s3_bucket_name" {
    type = string
}

variable aws_region {
    type = string
    default = "us-west-2"
}

variable aws_profile {
    type = string
    default = "default"
}