resource "argocd_application" "strimzi_kafka_operator" {
  metadata {
    name = "kafka"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/strimzi/strimzi-kafka-operator"
      target_revision = "0.46.0"
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

resource "argocd_application" "kafka_cluster" {
  metadata {
    name      = "my-cluster"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/mateuszjanczak/jobs-infrastructure.git"
      target_revision = "main"
      path            = "resources/kafka/cluster"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }
    }
  }

  depends_on = [argocd_application.strimzi_kafka_operator]
}


resource "argocd_application" "kafka_topic_example" {
  metadata {
    name      = "my-topic"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/mateuszjanczak/jobs-infrastructure.git"
      target_revision = "main"
      path            = "resources/kafka/topic"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }
    }
  }

  depends_on = [argocd_application.kafka_cluster]
}