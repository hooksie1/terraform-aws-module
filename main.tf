resource "aws_instance" "vm" {
    ami             = var.image
    instance_type   = var.size
    key_name        = var.key


    tags = {
        Name = var.name
    }
}

data "cloudflare_zones" "default" {
    filter{
        name        = var.cloudflare_zone
        status      = "active"
        paused      = "false"
    }
}

resource "cloudflare_record" "a_record" {
    zone_id     = lookup(data.cloudflare_zones[0], "name")
    name        = var.name
    value       = aws_instance.vm.public_ip
    type        = "A"
}
