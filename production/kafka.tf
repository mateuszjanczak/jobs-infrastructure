resource "argocd_application" "strimzi_kafka_operator" {
  metadata {
    name = "kafka"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/strimzi/strimzi-kafka-operator"
      target_revision = "HEAD"
      path            = "helm-charts/helm3/strimzi-kafka-operator"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
    }
  }
}
