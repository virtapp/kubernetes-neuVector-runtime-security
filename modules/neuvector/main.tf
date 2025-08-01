

resource "helm_release" "neuvector" {
  name       = "neuvector-core"
  namespace  = "neuvector"
  create_namespace = true
  repository = "https://neuvector.github.io/neuvector-helm/"
  chart      = "core"
  version    = "2.6.6" # or latest version you want to deploy
  # Optional: override default chart values
  #values = [
  #  file("./modules/neuvector/neuvector-values.yaml") # optional, for advanced config
  #]
  values = [yamlencode({
    controller = {
      replicas = 1
    }
})]
}

