output "application_address" {
  description = "application_address"
  value       =  "http://${data.kubernetes_service.talha_service_loadbalancer.status[0].load_balancer[0].ingress[0].ip}"
}
