# HashiCorp Vault — Setup (Development Cluster)

This guide documents how Vault is installed and initialized on the development cluster using Flux + Helm. It assumes Flux is bootstrapped and the cluster is healthy.

---

## 1) Install Vault via Helm (managed by Flux)

We use the official **hashicorp/vault** Helm chart (installed via a Flux `HelmRelease`). The chart deploys Vault (server + UI) into the cluster.

> Repo: `https://helm.releases.hashicorp.com`  
> Chart: `hashicorp/vault`

Ensure your `HelmRepository` and `HelmRelease` are committed in Git and reconciled by Flux.

---

## 2) Make sure persistent storage is available **before** Vault

Vault needs a **PersistentVolumeClaim** for its storage. If no default StorageClass is present, its PVC will stay **Pending**.

### Option A — Hetzner CSI 
1. Install the **Hetzner Cloud CSI** driver (via HelmRelease). Documentation [here](https://cloudfleet.ai/tutorials/cloud/use-persistent-volumes-with-cloudfleet-on-hetzner/). 
2. Verify a StorageClass exists (e.g., `hcloud-volumes`) and mark it default:
   ```bash
   kubectl get storageclass
   kubectl annotate storageclass hcloud-volumes storageclass.kubernetes.io/is-default-class="true" --overwrite
    ```

3. After this, Vault’s PVC should **bind automatically** and a PV will be created dynamically.

> If you prefer another provisioner (e.g., local-path) or another provider’s CSI, install that first, then return here.

---

## 3) Port-forward to the Vault UI for initialization

Once the hashicorp-vault-agent-injector pod is up, the hashicorp-vault pod will not be ready until the Vault init process is finished. To init Vault, forward the UI port:

```bash
# Replace namespace if different
kubectl -n vault get svc
# Example shows:
# NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)              AGE
# hashicorp-vault  ClusterIP   10.97.17.231   <none>        8200/TCP,8201/TCP    5m

kubectl -n vault port-forward svc/hashicorp-vault 8200:8200
```

Open: **[http://localhost:8200](http://localhost:8200)**

---

## 4) Initialize Vault (Shamir unseal keys)

On the UI (or via CLI), click **Initialize** and choose:

* **Key shares (N):** total number of unseal keys to generate
* **Key threshold (T):** how many of those must be entered to unseal Vault

> Typical dev values: `N=5`, `T=3`.
> In production choose values that match your operational model and key custodians.

**Important:** Save the generated **unseal keys** and the **initial root token** in a secure place (password manager / HSM-backed secret store). They are displayed **once** during init.

---

## 5) Unseal Vault

After initialization, Vault is still **sealed**. Enter **T** of the **N** unseal keys one-by-one (UI prompts for each) until the status changes to **Unsealed**.

You must repeat unseal on each Vault pod (if running HA) or when pods restart (unless using auto-unseal with a KMS, which is out of scope for this phase).

---

## 6) Log in with the root token

Once unsealed, log in using the **root token** shown during initialization.

* In the UI: choose “Token” method and paste the root token
* Or via CLI (if configured):

  ```bash
  export VAULT_ADDR=http://localhost:8200
  vault login <ROOT_TOKEN>
  ```

> The root token is powerful. In later phases, create scoped policies and non-root admin/service tokens, then store/rotate secrets centrally (Vault), not in Git.

---

## 7) Next steps (to be detailed)

*This section will be expanded with concrete manifests (Vault policy, auth config, `SecretStore`, `ExternalSecret`) in the next phase.*

---

## Troubleshooting

* **PVC Pending / no PV:** check `kubectl get sc` and ensure a default StorageClass is present; install CSI first.
* **Cannot reach UI:** confirm `port-forward` is active and service name/namespace is correct.
* **Unseal prompts keep appearing:** all pods must be unsealed; consider HA vs standalone mode and restarts.


