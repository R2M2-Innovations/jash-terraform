variable "alb_zone_id" {
  default     = "null"
  description = "alb zone id"
}

variable "dns_name" {
  default     = "null"
  description = "dns name"
}

variable "r53_alias" {
  description = "create r53 alias for alb"
}

variable "target_zone_id" {
  default     = "null"
  description = "route 53 hosted zone id"
}

variable "cname_alias" {
  default     = "null"
  description = "cname alias"
}


resource "aws_route53_record" "r53-cname-alias" {
  count = var.r53_alias ? 1 : 0
  zone_id = var.target_zone_id
  name = var.cname_alias
  type    = "A" 

  alias {
    zone_id                = var.alb_zone_id
    name                   = var.dns_name
    evaluate_target_health = false 
  }
}
