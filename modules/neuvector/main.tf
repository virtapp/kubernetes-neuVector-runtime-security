

resource "helm_release" "neuvector" {
  name             = "neuvector-core"
  namespace        = "neuvector"
  create_namespace = true

  repository = "https://neuvector.github.io/neuvector-helm/"
  chart      = "core"
  version    = "2.6.6"
  # Optional: override default chart values
  values = [yamlencode({
  controller = {
    replicas = 1
  }
  enforcer = {
    containerd = {
      enabled = true
    }
    dockerSock = {
      enabled = false
    }
    privileged = true  # important!
  }
  scanner = {
    enabled = true
  }
})]
}


