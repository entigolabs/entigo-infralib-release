<h1 align="center">Infralib Releases</h1>

<p align="center">
  <strong>Versioned, released snapshots of the Entigo Infralib Terraform / OpenTofu modules and Helm charts.</strong>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/github/license/entigolabs/entigo-infralib-release" alt="License"></a>
  <a href="https://www.entigo.com/infralib"><img src="https://img.shields.io/badge/website-entigo.com%2Finfralib-blue" alt="Website"></a>
</p>

<p align="center">
  <a href="https://github.com/entigolabs/entigo-infralib-agent">Agent</a> ·
  <a href="https://github.com/entigolabs/entigo-infralib">Modules (development)</a> ·
  <a href="https://www.entigo.com/infralib">Website</a>
</p>

---

> **This repository is generated.** It holds published releases only — no tests, no development history. **Please do not open pull requests here.** Module development happens in [entigo-infralib](https://github.com/entigolabs/entigo-infralib); to provision a platform, use the [agent](https://github.com/entigolabs/entigo-infralib-agent).

## Using a release

Reference a release by tag from Terraform / OpenTofu or ArgoCD, or consume it as an OCI source.

**Agent configuration**

```yaml
# OCI repository for AWS
sources:
  - url: oci://public.ecr.aws/entigolabs/entigo-infralib-release

# OCI repository for Google Cloud
sources:
  - url: oci://ghcr.io/entigolabs/entigo-infralib-release

# GIT repository for any
sources:
  - url: https://github.com/entigolabs/entigo-infralib-release
```

**Terraform / OpenTofu**

```hcl
module "main" {
  source                 = "git::https://github.com/entigolabs/entigo-infralib-release.git//modules/aws/vpc?ref=v1.0.14"
  prefix                 = "dev-net-main"
  elasticache_subnets    = []
  intra_subnets          = []
  one_nat_gateway_per_az = false
  vpc_cidr               = "10.112.0.0/16"
}
```

**ArgoCD Application**

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: 'external-dns-dev'
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: 'external-dns-dev'
  project: default
  sources:
    - repoURL: 'https://github.com/entigolabs/entigo-infralib-release.git'
      targetRevision: 'v1.0.14'
      path: "modules/k8s/external-dns"
      helm:
        ignoreMissingValueFiles: true
        valueFiles:
          - 'values.yaml'
          - 'values-aws.yaml'
        values: |
          global:
              aws:
                  account: "XXXX"
                  clusterOIDC: oidc.eks.eu-north-1.amazonaws.com/id/XXXX
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
      - RespectIgnoreDifferences=true
```

## License

Licensed under [AGPL-3.0](LICENSE). For commercial licensing, contact [entigo.com](https://www.entigo.com).
