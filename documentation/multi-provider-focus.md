# Cloudlab Platform Playground (EU Multi-Provider Focus)

This repository is a **platform engineering playground** built around a practical constraint: a Kubernetes platform should be operable using **European providers** and remain portable across providers and environments. What started as a multi-provider Proof-of-Concept has expanded into a wider test ground for building, operating, and documenting a production-style platform using GitOps.

Multi-provider deployment is still a core theme, but it is treated as one of the platform’s capabilities rather than the only objective.


## Goals

* Build a **repeatable, production-style platform baseline** (GitOps-first, secure-by-default, observable).
* Validate **multi-provider deployment patterns** on European providers (currently Hetzner and Scaleway) and keep the design extensible to additional providers over time.
* Maintain a repository structure that supports:

  * progressive hardening
  * clear separation of concerns (infrastructure, platform services, applications)
  * environment overlays and provider overlays
* Produce **credible documentation** that explains design decisions, operational workflows, and trade-offs.


## What “multi-provider” means in this repo

Multi-provider is implemented as a **practical platform requirement**, not as an academic demo.

Examples:

* A single logical cluster can include nodes from multiple providers.
* Workloads can be scheduled to a specific provider or zone when needed (cost, latency, failure-domain isolation).
* Provider-specific dependencies (such as storage) are handled explicitly through overlays and dedicated drivers.
* Some workloads are intentionally deployed twice across providers to reduce the impact of provider-level incidents.


## Platform scenarios exercised here

### 1) Multi-provider workload placement (single cluster)

Run workloads in the same cluster across nodes from different providers, with explicit placement controls.

**Purpose**

* Demonstrate predictable scheduling across failure domains (provider, zone).
* Validate that platform services and workloads behave correctly when nodes are heterogeneous.

**How**

* Node labeling and targeted scheduling (`nodeSelector`, topology labels).
* Provider overlays per workload where provider-specific configuration is required.
* Observability confirms where workloads run and how they behave.


### 2) Provider-specific storage as a first-class concern

Storage is treated explicitly because it is typically the first “multi-cloud reality check”.

**Purpose**

* Ensure PVC-backed workloads can run on different providers without relying on a single provider’s storage backend.

**How**

* Provider-specific CSI drivers where appropriate (e.g., Scaleway CSI).
* Provider-specific StorageClasses, selected per workload/overlay.
* Default StorageClass behavior is not relied upon in a mixed-provider cluster; PVCs declare `storageClassName` where required.


### 3) Shared platform services with environment/provider overlays

The repo is structured so platform components can be introduced and iterated in a controlled way.

**Purpose**

* Build a platform layer that resembles real operational practices.
* Keep changes reviewable and reproducible.

**How**

* Flux reconciliation for declarative lifecycle management.
* Helm + Kustomize overlays to separate base definitions from environment/provider specifics.
* Clear separation between:

  * infrastructure enablement (e.g., storage drivers)
  * platform services (e.g., Vault, observability)
  * applications/workloads used to validate platform behavior


### 4) Resilience and continuity patterns (iterative)

Resilience is approached pragmatically and incrementally.

**Purpose**

* Reduce the blast radius of provider incidents.
* Validate the operational model for recovery and continuity.

**How**

* Certain workloads are deployed per provider (e.g., Pi-hole in Hetzner and Scaleway).
* Future iterations may include multi-cluster failover patterns, depending on scope and learning objectives.


## Core pillars

| Pillar                  | Description                                       | Examples                      |
| ----------------------- | ------------------------------------------------- | ----------------------------- |
| Platform infrastructure | Kubernetes cluster extended across EU providers   | Cloudfleet, Hetzner, Scaleway |
| GitOps lifecycle        | Declarative, reviewable platform changes          | FluxCD, Helm, Kustomize       |
| Observability           | Unified metrics/logs and platform visibility      | Prometheus, Grafana, Loki     |
| Security                | Central secret management and secure defaults     | Vault, VSO, policy baseline   |
| Workloads               | Real deployments to validate platform behavior    | Pi-hole, supporting services  |
| EU provider focus       | Provider choice and data locality as a constraint | EU regions, provider overlays |


## Implementation approach

Work is organized as incremental platform deliverables rather than a fixed “PoC timeline”. Each capability (storage, secrets, workload placement, exposure/access) is introduced in a way that can be validated and documented.

Examples of deliverables:

* Provider-aware workload placement verified by scheduling and dashboards
* Storage enablement per provider (CSI + StorageClass + PVC-backed workload)
* Shared VaultAuth with instance-specific secret materialization via VSO
* Secure internal access patterns (e.g., Tailscale exposure for selected services)


## Expected outcomes

* A **credible platform engineering showcase**: not just deployed manifests, but an operationally coherent system.
* Demonstrated ability to:

  * operate GitOps workflows end-to-end
  * introduce platform components safely
  * reason about provider constraints (especially storage and scheduling)
  * document decisions and trade-offs in a professional manner
* A repository structure that can scale to additional providers, services, and environments without becoming unmanageable.