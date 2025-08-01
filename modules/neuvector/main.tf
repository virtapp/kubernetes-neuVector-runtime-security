
resource "helm_release" "neuvector" {
  name             = "neuvector-core"
  namespace        = "neuvector"
  create_namespace = true

  repository = "https://neuvector.github.io/neuvector-helm/"
  chart      = "core"
  version    = "2.8.2"

  values = [yamlencode({
    rbac = {
      create = true
    }
    controller = { replicas = 1 }

    enforcer = {
      privileged = true
      containerd  = { enabled = true }
      dockerSock  = {
        enabled = false
        mountPath = ""
      }
    }

    scanner = { enabled = true }
  })]
}
