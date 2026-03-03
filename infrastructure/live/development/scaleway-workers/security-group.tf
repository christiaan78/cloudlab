resource "scaleway_instance_security_group" "cfke_worker" {
  name                    = "cfke-worker-sg"
  zone                    = var.scaleway_zone
  stateful                = true
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action   = "accept"
    ip_range = var.workstation_ip
    protocol = "TCP"
    port     = "22"
  }
}