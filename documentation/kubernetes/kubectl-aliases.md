# Kubectl Aliases Reference

## Aliases

| Alias  | Command                        | Description                                                       |
|--------|--------------------------------|-------------------------------------------------------------------|
| k      | kubectl                        | The kubectl command                                               |
| kca    | kubectl --all-namespaces       | Target all namespaces                                             |
| kaf    | kubectl apply -f               | Apply a YAML file                                                 |
| keti   | kubectl exec -ti               | Drop into an interactive terminal on a container                 |

### Manage configuration quickly (contexts)

| Alias  | Command                                  | Description                                                   |
|--------|------------------------------------------|---------------------------------------------------------------|
| kcuc   | kubectl config use-context               | Set the current context in a kubeconfig file                 |
| kcsc   | kubectl config set-context               | Set a context entry in kubeconfig                             |
| kcdc   | kubectl config delete-context            | Delete the specified context                                  |
| kccc   | kubectl config current-context           | Display current context                                       |
| kcgc   | kubectl config get-contexts              | List of available contexts                                    |

### General aliases

| Alias  | Command                     | Description                                                       |
|--------|-----------------------------|-------------------------------------------------------------------|
| kdel   | kubectl delete              | Delete resources by filenames, stdin, resource names, or labels   |
| kdelf  | kubectl delete -f           | Delete a pod using the type/name specified in -f                  |
| kge    | kubectl get events --sort-by=".lastTimestamp" | Get events sorted by timestamp                   |
| kgew   | kubectl get events --watch --sort-by=".lastTimestamp" | Watch events as they occur                   |

### Pod management

| Alias   | Command                      | Description                                                   |
|---------|------------------------------|---------------------------------------------------------------|
| kgp     | kubectl get pods             | List all pods in ps output format                              |
| kgpl    | kgp -l                        | Get pods by label, e.g., `kgpl "app=myapp" -n myns`           |
| kgpn    | kgp -n                        | Get pods by namespace, e.g., `kgpn kube-system`               |
| kgpsl   | kubectl get pods --show-labels | List pods with labels                                       |
| kgpw    | kgp --watch                  | Watch for changes after listing pods                           |
| kgpwide | kgp -o wide                  | Output pod info including node name                             |
| kep     | kubectl edit pods            | Edit pods from default editor                                   |
| kdp     | kubectl describe pods        | Describe all pods                                               |
| kdelp   | kubectl delete pods          | Delete all pods matching arguments                               |

### Service management

| Alias   | Command               | Description                                           |
|---------|-----------------------|-------------------------------------------------------|
| kgs     | kubectl get svc       | List all services                                     |
| kgsw    | kgs --watch           | Watch for changes in services                         |
| kgswide | kgs -o wide           | Output services with additional info                  |
| kes     | kubectl edit svc      | Edit services                                         |
| kds     | kubectl describe svc  | Describe services                                     |
| kdels   | kubectl delete svc    | Delete services                                       |

### Ingress management

| Alias | Command                  | Description                     |
|-------|--------------------------|---------------------------------|
| kgi   | kubectl get ingress      | List ingress resources          |
| kei   | kubectl edit ingress     | Edit ingress                    |
| kdi   | kubectl describe ingress | Describe ingress                |
| kdeli | kubectl delete ingress   | Delete ingress                  |

### Namespace management

| Alias   | Command                                             | Description                             |
|---------|-----------------------------------------------------|-----------------------------------------|
| kgns    | kubectl get namespaces                              | List current namespaces                  |
| kcn     | kubectl config set-context --current --namespace   | Change current namespace                 |
| kens    | kubectl edit namespace                              | Edit namespace                            |
| kdns    | kubectl describe namespace                          | Describe namespace                        |
| kdelns  | kubectl delete namespace                             | Delete namespace (WARNING: deletes all) |

### ConfigMap management

| Alias   | Command                     | Description             |
|---------|-----------------------------|-------------------------|
| kgcm    | kubectl get configmaps      | List configmaps         |
| kecm    | kubectl edit configmap      | Edit configmap          |
| kdcm    | kubectl describe configmap  | Describe configmap      |
| kdelcm  | kubectl delete configmap    | Delete configmap        |

### Secret management

| Alias   | Command                   | Description          |
|---------|---------------------------|--------------------|
| kgsec   | kubectl get secret        | Get secret for decoding |
| kdsec   | kubectl describe secret   | Describe secret      |
| kdelsec | kubectl delete secret     | Delete secret        |

### Deployment management

| Alias    | Command                       | Description                                           |
|----------|-------------------------------|-------------------------------------------------------|
| kgd      | kubectl get deployment         | Get deployment                                        |
| kgdw     | kgd --watch                    | Watch deployment                                      |
| kgdwide  | kgd -o wide                    | Output deployment info                                |
| ked      | kubectl edit deployment        | Edit deployment                                       |
| kdd      | kubectl describe deployment    | Describe deployment                                   |
| kdeld    | kubectl delete deployment      | Delete deployment                                     |
| ksd      | kubectl scale deployment       | Scale deployment                                      |
| krsd     | kubectl rollout status deployment | Check rollout status                                |
| krrd     | kubectl rollout restart deployment | Rollout restart deployment                          |
| kres     | kubectl set env $@ REFRESHED_AT=... | Recreate pods zero-downtime                        |

### Rollout management

| Alias  | Command                      | Description                 |
|--------|-------------------------------|-----------------------------|
| kgrs   | kubectl get replicaset        | List ReplicaSets            |
| kdrs   | kubectl describe replicaset   | Describe ReplicaSet         |
| kers   | kubectl edit replicaset       | Edit ReplicaSet             |
| krh    | kubectl rollout history       | Check deployment revisions  |
| kru    | kubectl rollout undo          | Rollback to previous        |

### Port forwarding

| Alias | Command                  | Description                |
|-------|--------------------------|----------------------------|
| kpf   | kubectl port-forward     | Forward local ports to pod |

### Tools / General

| Alias | Command                  | Description                |
|-------|--------------------------|----------------------------|
| kga   | kubectl get all          | List all resources         |
| kgaa  | kubectl get all --all-namespaces | List all in all namespaces |

### Logs

| Alias | Command           | Description                   |
|-------|-----------------|-------------------------------|
| kl    | kubectl logs     | Print container/resource logs  |
| klf   | kubectl logs -f  | Stream logs (follow)          |

### File copy

| Alias | Command           | Description             |
|-------|-----------------|-------------------------|
| kcp   | kubectl cp       | Copy files to/from container |

### Node management

| Alias  | Command                      | Description                       |
|--------|-------------------------------|-----------------------------------|
| kgno   | kubectl get nodes             | List nodes                         |
| kgnosl | kubectl get nodes --show-labels | List nodes with labels           |
| keno   | kubectl edit node             | Edit nodes                          |
| kdno   | kubectl describe node         | Describe nodes                       |
| kdelno | kubectl delete node           | Delete nodes                        |

### Persistent Volume Claim (PVC) management

| Alias  | Command             | Description                     |
|--------|-------------------|---------------------------------|
| kgpvc  | kubectl get pvc     | List all PVCs                    |
| kgpvcw | kgpvc --watch       | Watch PVCs                        |
| kepvc  | kubectl edit pvc    | Edit PVC                          |
| kdpvc  | kubectl describe pvc| Describe PVC                       |
| kdelpvc| kubectl delete pvc  | Delete PVC                         |

### StatefulSets management

| Alias   | Command                   | Description                         |
|---------|---------------------------|-------------------------------------|
| kgss    | kubectl get statefulset   | List StatefulSets                    |
| kgssw   | kgss --watch              | Watch StatefulSets                   |
| kgsswide| kgss -o wide              | Output StatefulSets with info        |
| kess    | kubectl edit statefulset  | Edit StatefulSet                     |
| kdss    | kubectl describe statefulset | Describe StatefulSet               |
| kdelss  | kubectl delete statefulset | Delete StatefulSet                  |
| ksss    | kubectl scale statefulset | Scale StatefulSet                   |
| krsss   | kubectl rollout status statefulset | Check rollout status          |
| krrss   | kubectl rollout restart statefulset | Rollout restart               |

### Service Accounts management

| Alias  | Command                 | Description                     |
|--------|------------------------|---------------------------------|
| kdsa   | kubectl describe sa     | Describe service account        |
| kdelsa | kubectl delete sa       | Delete service account          |

### DaemonSet management

| Alias  | Command                   | Description                      |
|--------|---------------------------|----------------------------------|
| kgds   | kubectl get daemonset      | List DaemonSets                  |
| kgdsw  | kgds --watch               | Watch DaemonSets                  |
| keds   | kubectl edit daemonset     | Edit DaemonSets                   |
| kdds   | kubectl describe daemonset | Describe DaemonSets               |
| kdelds | kubectl delete daemonset   | Delete DaemonSets                 |

### CronJob management

| Alias   | Command                  | Description                       |
|---------|--------------------------|-----------------------------------|
| kgcj    | kubectl get cronjob      | List CronJobs                     |
| kecj    | kubectl edit cronjob     | Edit CronJob                      |
| kdcj    | kubectl describe cronjob | Describe CronJob                  |
| kdelcj  | kubectl delete cronjob   | Delete CronJob                    |

### Job management

| Alias  | Command                 | Description                       |
|--------|------------------------|-----------------------------------|
| kgj    | kubectl get job        | List Jobs                          |
| kej    | kubectl edit job       | Edit Job                           |
| kdj    | kubectl describe job   | Describe Job                       |
| kdelj  | kubectl delete job     | Delete Job                         |
