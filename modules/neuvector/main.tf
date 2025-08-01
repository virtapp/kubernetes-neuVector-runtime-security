
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

    controller = {
      replicas = 1
    }

    enforcer = {
      privileged = true

      # Disable Docker socket usage entirely
      dockerSock = {
        enabled = false
        mountPath = ""
      }

      # Explicitly enable containerd
      containerd = {
        enabled = true
        sockPath = "/run/k3s/containerd/containerd.sock"  # For K3s
      }

      # Some versions of NeuVector also respect this field:
      runtime = "containerd"

      # Optional fallback path override (can help older agents)
      runtimePath = "/run/k3s/containerd/containerd.sock"
    }

    scanner = {
      enabled = true
    }
  })]
}
