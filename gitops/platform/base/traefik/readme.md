# Traefik — Install Summary (Development Cluster)

## What is installed
- **Charts**
  - `traefik-crds` (CRDs managed separately)
  - `traefik` (controller, CRDs skipped)
- **Helm repo**: `https://traefik.github.io/charts`
- **Chart note (v34+)**: `ports.web.redirectTo` was removed → use `ports.web.redirections.entryPoint` (HTTP→HTTPS).

## How it’s structured (GitOps)
- **Base**: namespace-agnostic HelmReleases (CRDs + controller), general values.
- **Development overlay**:
  - Sets namespace: `ingress-traefik`
  - Patches only env-specific values (e.g., Service type)
- **Order**: `traefik-crds` deploys first; `traefik` depends on it.

## Safety defaults (dev)
- **Internal-only**: `service.type: ClusterIP` (no external LB; not publicly reachable).
- **HTTPS redirect**: enabled via `redirections.entryPoint` (web → websecure).
- **Dashboard exposure**: **off** by default (only exposed if you add an Ingress/IngressRoute).
- **Ingress class**: `traefik` (not default class in dev).

## Operational notes
- **CRDs lifecycle**: managed by the `traefik-crds` release; the controller is installed with **CRDs skipped** to avoid drift/upgrade issues.
- **Reconcile**: Flux manages both releases; use `flux reconcile source git` / `flux reconcile kustomization …` to apply changes.

## Production later
- Flip only the overlay patch:
  - `service.type: LoadBalancer` (public ingress when ready)
  - Optionally set `ingressClass.isDefaultClass: true`
  - Add ACME (Cloudflare DNS-01) values for public TLS
- Keep the same base; reuse CRDs first → controller order.