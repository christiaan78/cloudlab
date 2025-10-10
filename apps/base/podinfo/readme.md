# Podinfo (Demo Application)

This is the **Podinfo** demo application: a microservices app that’s useful for testing routing, metrics, traceability, and cloud-aware behavior in your Kubernetes clusters.

This version uses the [Helm chart from the official repo](https://github.com/stefanprodan/podinfo/tree/master/charts/podinfo) :contentReference[oaicite:0]{index=0}

---

## Why Podinfo?

- Very lightweight and easy to deploy  
- Exposes metrics, endpoints, and version information  
- You can configure it to display *which node/provider* it’s running on  
- Ideal for showcasing **multi-cloud-aware workloads**  
- Useful in failover / routing / observability demos  

---

## Chart structure & values

The upstream chart defines microservices:

- `frontend`: UI and public entrypoint (port 80)  
- `backend`: main API, metrics, health endpoints (default ports 9898 & 9999)  
- `cache`: optional Redis-backed cache (port 6379)

You can override values such as `replicaCount`, `image.tag`, etc., in your Helm values overlay.

---

Once reconciled by Flux, you will have the `frontend`, `backend`, and `cache` services deployed in the `apps` namespace.

---

## Accessing Podinfo Locally

To check it manually via port-forward:

```bash
# Forward frontend (UI)
kubectl -n apps port-forward svc/frontend 8080:80

# Then open in browser:
open http://localhost:8080
```

You can also port-forward the backend:

```bash
kubectl -n apps port-forward svc/backend 9898:9898
```

Visit `http://localhost:9898` to see JSON responses, /metrics, /healthz, etc.

---

## Podinfo in the multi-cloud PoC

In this PoC setup:

1. I have deployed **Podinfo** across node pools in multiple providers (Hetzner, Scaleway, etc.).
2. Used **taints & tolerations / nodeSelectors** so each instance pinpoints a specific provider.
3. Adjusted the UI to show which provider it's running on.
4. Used the health check in the **failover scenario**: when one provider goes down, Podinfo traffic shifts to another nodes or cluster. 
5. Observe metrics, latency, and provider spread in Grafana / Prometheus dashboards. 
