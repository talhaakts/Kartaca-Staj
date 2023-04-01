resource "kubernetes_deployment" "talha-deployment" {
  metadata {
    name = "talha-deployment"
    labels = {
      App = "kartaca_staj"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "kartaca_staj"
      }
    }
    template {
      metadata {
        labels = {
          App = "kartaca_staj"
        }
      }
      spec {
        container {
          image = "talhaakts/kartaca-staj:v1"
          name  = "kartaca-staj"

          port {
            container_port = 5000
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "talha-service" {
  metadata {
    name = "talha-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.talha-deployment.metadata.0.labels.App
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}

data "kubernetes_service" "talha_service_loadbalancer" {
  metadata {
    name = "talha-service"
  }
  depends_on = [kubernetes_service.talha-service]
}
