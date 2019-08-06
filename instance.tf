resource "aws_key_pair" "terraria-admin" {
    key_name = "terraria-admin"
    public_key = "${file("~/.ssh/terraria-admin-public.pub")}"
}

resource "aws_security_group" "allow-terraria" {
    name = "allow-terraria"
    description = "Allow inbound Terraria connections"
    vpc_id = "${aws_vpc.terraria-vpc.id}"

    ingress {
      from_port = 7777
      to_port = 7777
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-ssh" {
    name = "allow-ssh"
    description = "Allow inbound SSH connections"
    vpc_id = "${aws_vpc.terraria-vpc.id}"

    ingress {
      from_port = 22
      to_port = 22
      protocol    = "TCP"
      cidr_blocks = ["64.46.22.244/32"] #for now this whitelists me
    }
}

resource "aws_instance" "terraria-dedicated" {
    ami = "ami-082b5a644766e0e6f"
    subnet_id = "${aws_subnet.terraria-vpc-public-1.id}"
    instance_type = "t2.medium"
    key_name = "${aws_key_pair.terraria-admin.key_name}"
    user_data = "${file("userdata.sh")}"
    security_groups = [
      "${aws_security_group.allow-ssh.id}",
      "${aws_security_group.allow-terraria.id}"
    ]
    tags = {
        Name = "Terraria Dedicated Server (Medium)"
    }
}