
resource "helm_release" "neuvector" {
  name             = "neuvector-core"
  namespace        = "neuvector"
  create_namespace = true

  repository = "https://neuvector.github.io/neuvector-helm/"
  chart      = "core"
  version    = "2.8.2"

  values = [yamlencode({
    controller = { replicas = 1 }
    enforcer = {
      privileged = true
      containerd  = { enabled = true }
      dockerSock  = { enabled = false }
    }
    scanner = { enabled = true }
  })]
}
