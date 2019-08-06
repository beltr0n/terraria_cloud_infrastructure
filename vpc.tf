resource "aws_vpc" "terraria-vpc" {
  cidr_block       = "192.168.0.0/16"
  tags = {
    Name = "Terraria VPC"
  }
}

resource "aws_subnet" "terraria-vpc-public-1" {
    vpc_id = "${aws_vpc.terraria-vpc.id}"
    cidr_block = "192.168.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2a"

    tags = {
        Name = "terraria-vpc-public-1"
    }
}

resource "aws_subnet" "terraria-vpc-private-1" {
    vpc_id = "${aws_vpc.terraria-vpc.id}"
    cidr_block = "192.168.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2a"

    tags = {
        Name = "terraria-vpc-private-1"
    }
}

resource "aws_internet_gateway" "terraria-vpc-gw" {
    vpc_id = "${aws_vpc.terraria-vpc.id}"

    tags = {
        Name = "terraria-vpc-gw"
    }
}

resource "aws_route_table" "terraria-vpc-public" {
    vpc_id = "${aws_vpc.terraria-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.terraria-vpc-gw.id}"
    }

    tags = {
        Name = "terraria-vpc-public-1"
    }
}

resource "aws_route_table_association" "terraria-vpc-public-1-a" {
    subnet_id = "${aws_subnet.terraria-vpc-public-1.id}"
    route_table_id = "${aws_route_table.terraria-vpc-public.id}"
}