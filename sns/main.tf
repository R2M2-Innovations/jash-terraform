module "sns_topic" {
  source = "../modules/sns"
  name = "${var.organization}-${var.application}-${var.environment}-${var.stack_id}"
  kms_key = var.kms_key
  fifo_topic = var.fifo_topic
}
