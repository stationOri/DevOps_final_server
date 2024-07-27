resource "aws_subnet" "ori-subnet-public-01" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.0.0/20"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true
    tags = { Name = "ori-subnet-public-01"} 
}

resource "aws_subnet" "ori-subnet-public-02" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.16.0/20"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true 
    tags = { Name = "ori-subnet-public-02"}
}

resource "aws_subnet" "ori-subnet-private-01" {
    vpc_id = var.vpc_id
    cidr_block  = "10.0.64.0/20"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = false
    tags = { Name = "ori-subnet-private-01"}
}


resource "aws_subnet" "ori-subnet-private-02" {
    vpc_id = var.vpc_id
    cidr_block  = "10.0.80.0/20"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = false
    tags = { Name = "ori-subnet-private-02"}
}