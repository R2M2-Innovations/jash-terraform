variable "name" {
  description = "sns topic name"
}

variable "fifo_topic" {
  description = "fifo topic [ true | false ]"
}

variable "kms_key" {
  description = "kms_key"
}

resource "aws_sns_topic" "sns_topic" {
  name = var.name
  fifo_topic = var.fifo_topic
  kms_master_key_id = var.kms_key
}
