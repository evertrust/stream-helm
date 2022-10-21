# stream-helm

## Overview
This is the official Helm Chart for installing stream on Kubernetes.

## Installation

Add the Helm repo to your local repositories :
```shell
helm repo add evertrust https://repo.evertrust.io/repository/charts
```

You can then use the Chart using the prefix you chose :
```shell
helm install stream evertrust/stream
```
## Usage

### Image pull secret
Because the stream Docker image is not publicly available, you must provide the chart with registry credentials to pull the image.

This can be done via the `kubectl` command :
```shell
kubectl create secret docker-registry evertrust-registry \
--docker-server=registry.evertrust.io \
--docker-username=<username> \
--docker-password=<password>
```
If deploying to a specific namespace, don't forget to namespace the secret accordingly.

Once done, tell the chart to use the newly created secret by adding an entry in the `image.pullSecrets` key in `values.yaml`:
```yaml
image:
  pullSecrets:
    - evertrust-registry
```

### License
You must also have a valid license to deploy stream. Create a secret in the namespace you want to deploy stream to :
```shell
kubectl create secret generic stream-license \
--from-literal="license=<license>"
```
When doing so, take care to remove newlines in your license.

Then, reference it in your `values.yaml` under the `license` key:
```yaml
license:
  secretName: stream-license
  secretKey: license
```

### Secrets
Secret values should not be stored in your `values.yaml` file in a production environment.
Instead, you should create Kubernetes secrets beforehand or inject them directly into the pod.

Values that should be treated as secrets in this chart are :
- `appSecret`
- `vaults.*.master_password`
- `mailer.password`
- `externalDatabase.uri`

For each of these values, either :
- leave the field empty, so that a secret will be automatically generated.*
- specify a value directly (not recommended in productions as Helm values are exposed) :
```yaml
appSecret:
  value: <app secret>
```
- derive the secret value from an existing Kubernetes secret :
```yaml
appSecret:
  valueFrom:
    secretKeyRef:
      name: <secret name>
      key: <secret key>
```

> **Warning**: Always store auto-generated secrets in a safe place after they're generated. If you ever uninstall your Helm chart, the deletion of the SSV secret will lead to the impossibility of recovering most of your data.

### Database
When installing the chart, you face multiple options regarding your database :

- By default, a local MongoDB standalone instance will be spawned in your cluster, using the [`bitnami/mongodb`](https://github.com/bitnami/charts/tree/master/bitnami/mongodb) chart. No additional configuration is required but it is not production ready.
- If you want to use an existing MongoDB instance, provide the `externalDatabase.uri` value. The URI should be treated as a secret as it must include credentials.

### Ingress
To create an ingress upon installation, simply set the following keys in your values.yaml override file :
```yaml
ingress:
  enabled: true
  hostname: stream.lab
  tls: true
```
We support autoconfiguration for major ingress controllers : Kubernetes Ingress NGINX and Traefik. Autoconfiguration is the recommended way of configuring your ingress as it will handle configuration quirks for you. To enable autoconfiguration, set the `type` key to your ingress controller in the ingress definition. Accepted values are `nginx` and `traefik`.
```yaml
ingress:
  enabled: true
  type: "" # nginx or traefik
  clientCertificateAuth: true
  hostname: stream.lab
  tls: true
```
`clientCertificateAuth` can be used to control whether to ask for a client certificates when users access stream.

If you wish to manually configure your ingress or use another ingress controller, head to the [Manual ingress configuration](#manual-ingress-configuration) section.

## Upgrading
We recommended that you only change values you need to customize in your `values.yml` file to ensure smooth upgrading.
Always check the upgrading instructions between chart versions.

### Upgrading the database
When upgrading stream, you'll need to run a migration script against the MongoDB database.
The chart will automatically create a `Job` that runs that upgrade script each time you upgrade your release if  `upgrade.enabled` is set to `true`.

> **Note**: if the upgrade job fails to run, check the job's pod logs. When upgrading from an old version of stream, you may need to explicitly specify the version you're upgrading from using the `upgrade.from` key. 

### Specific chart upgrade instructions

#### Upgrading to 0.3.0

- Loggers are now configured with an array instead of a dictionary. Check the `values.yaml` format and update your override `values.yaml` accordingly.
- The init dabatabase parameters (`initDatabase`, `initUsername` and `initPassword`) have been renamed and moved to `mongodb.stream`. 

#### Upgrading to 0.5.0
- The ingress definition has changed. The `rules` and `tls` keys have been removed in favor of a more user-friendly `hostname` that will autconfigure the ingress rules, and a boolean `tls` key that will enable TLS on that ingress. Check the [Ingress](#ingress) section.

## Advanced

### Running behind a Docker registry proxy
If your installation environment requires you to whitelist images that can be pulled by the Kubernetes cluster, you must whitelist the `registry.evertrust.io/stream` and `registry.evertrust.io/stream-upgrade` images.

### Leases
To ensure clustering issues get resolved as fast as possible, stream can use a CRD (Custom Resource Definition) named `Lease` (`akka.io/v1/leases`). We strongly recommend that you use this mechanism, however it implies that you have the necessary permissions to install CRDs onto your server. In case you don't, the feature can be disabled by passing the `--skip-crds` flag to the Helm command when installing the chart, and setting the `leases.enabled` key to `false`.
If you want to manually install the CRD, you can check the [leases.yml](crds/leases.yml) file.


### Injecting extra configuration
Extra stream configuration can be injected to the bundled `application.conf` file to modify low-level behavior of stream. This should be used carefully as it may cause things to break. To do so, just mount a folder in the stream container at `/stream/etc/conf.d/` containing a `custom.conf` file.

This can be done with the following edits to your `values.yaml` file :
```yaml
extraVolumes:
  - name: additional-config
    configMap:
      name: additional-config

extraVolumeMounts:
  - name: additional-config
    mountPath: /stream/etc/conf.d
```
Where the `additional-config` configmap contains a single key with your custom configuration :
```yaml
apiVersion: v1
kind: ConfigMap
data:
  custom.conf: |-
    play.server.http.port = 9999
```
Extra configurations are included at the end of the config file, overriding any previously set config value.

### Manual ingress configuration
If you do not wish or cannot use autoconfiguration, you should ensure your ingress controller is correctly configured to enable all stream features.
- When requiring client certificates for authentication, the web server should not perform checks to validate that the certificate is signed by a trusted CA. Instead, the certificate should be sent to stream through a request header, base64-encoded. The header name used can be controlled using the `clientCertificateHeader`.
- Some endpoints should not be server over HTTPS, in particular those used for SCEP enrollment. You may want to create an HTTP-only ingress for serving paths prefixed by `/scep` and `/certsrv`, and prevent those from redirecting to HTTPS.

## Parameters

### Global parameters

| Name                | Description                                                          | Value |
| ------------------- | -------------------------------------------------------------------- | ----- |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set) | `""`  |
| `nameOverride`      | String to partially override stream.fullname                        | `""`  |
| `fullnameOverride`  | String to fully override stream.fullname                            | `""`  |
| `imageRegistry`     | String to override the image registry for all containers             | `""`  |
| `commonLabels`      | Labels to add to all deployed objects                                | `{}`  |
| `commonAnnotations` | Annotations to add to all deployed objects                           | `{}`  |


### stream deployment parameters

| Name                                    | Description                                                                               | Value                   |
| --------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------- |
| `image.registry`                        | stream image registry                                                                    | `registry.evertrust.io` |
| `image.repository`                      | stream image repository                                                                  | `stream`                |
| `image.tag`                             | stream image tag (immutable tags are recommended)                                        | `2.3.0`                 |
| `image.pullPolicy`                      | stream image pull policy                                                                 | `IfNotPresent`          |
| `image.pullSecrets`                     | stream image pull secrets                                                                | `[]`                    |
| `updateStrategy.type`                   | stream deployment strategy type                                                          | `RollingUpdate`         |
| `updateStrategy.rollingUpdate`          | Rolling update spec                                                                       | `{}`                    |
| `priorityClassName`                     | stream pod priority class name                                                           | `""`                    |
| `hostAliases`                           | stream pod host aliases                                                                  | `[]`                    |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for stream pods                      | `[]`                    |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for stream container(s)         | `[]`                    |
| `sidecars`                              | Add additional sidecar containers to the stream pod                                      | `[]`                    |
| `lifecycleHooks`                        | Add lifecycle hooks to the stream deployment                                             | `{}`                    |
| `podLabels`                             | Extra labels for stream pods                                                             | `{}`                    |
| `podAnnotations`                        | Annotations for stream pods                                                              | `{}`                    |
| `podAffinityPreset`                     | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                    |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                  |
| `nodeAffinityPreset.type`               | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                    |
| `nodeAffinityPreset.key`                | Node label key to match. Ignored if `affinity` is set                                     | `""`                    |
| `nodeAffinityPreset.values`             | Node label values to match. Ignored if `affinity` is set                                  | `[]`                    |
| `affinity`                              | Affinity for pod assignment                                                               | `{}`                    |
| `nodeSelector`                          | Node labels for pod assignment                                                            | `{}`                    |
| `tolerations`                           | Tolerations for pod assignment                                                            | `[]`                    |
| `resources.limits`                      | The resources limits for the stream container                                            | `{}`                    |
| `resources.requests`                    | The requested resources for the stream container                                         | `{}`                    |
| `podSecurityContext.enabled`            | Enabled stream pods' Security Context                                                    | `true`                  |
| `podSecurityContext.fsGroup`            | Set stream pod's Security Context fsGroup                                                | `1001`                  |
| `containerSecurityContext.enabled`      | Enabled stream containers' Security Context                                              | `true`                  |
| `containerSecurityContext.runAsUser`    | Set stream container's Security Context runAsUser                                        | `1001`                  |
| `containerSecurityContext.runAsNonRoot` | Set stream container's Security Context runAsNonRoot                                     | `true`                  |
| `livenessProbe.enabled`                 | Enable livenessProbe                                                                      | `true`                  |
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `0`                     |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`                    |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`                     |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `3`                     |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`                     |
| `startupProbe.enabled`                  | Enable startupProbe. Since stream is slow to start, this is highly recommended.          | `true`                  |
| `startupProbe.periodSeconds`            | Period seconds for startupProbe                                                           | `3`                     |
| `startupProbe.failureThreshold`         | Failure threshold for startupProbe                                                        | `60`                    |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`                  |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `0`                     |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `5`                     |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `3`                     |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `3`                     |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`                     |
| `streamtalAutoscaler.enabled`          | Enable streamtal POD autoscaling for stream                                             | `false`                 |
| `streamtalAutoscaler.minReplicas`      | Minimum number of stream replicas                                                        | `1`                     |
| `streamtalAutoscaler.maxReplicas`      | Maximum number of stream replicas                                                        | `3`                     |
| `streamtalAutoscaler.targetCPU`        | Target CPU utilization percentage                                                         | `50`                    |
| `streamtalAutoscaler.targetMemory`     | Target Memory utilization percentage                                                      | `50`                    |
| `disruptionBudget.enabled`              | Created a PodDisruptionBudget                                                             | `false`                 |
| `disruptionBudget.minAvailable`         | Min number of pods that must still be available after the eviction                        | `1`                     |
| `disruptionBudget.maxUnavailable`       | Max number of pods that can be unavailable after the eviction                             | `0`                     |
| `environment`                           | Extra env vars passed to the stream pods                                                 | `[]`                    |


### stream Service configuration

| Name                               | Description                                           | Value       |
| ---------------------------------- | ----------------------------------------------------- | ----------- |
| `service.type`                     | Kubernetes service type                               | `ClusterIP` |
| `service.clusterIP`                | stream service clusterIP IP                          | `""`        |
| `service.loadBalancerIP`           | for the stream Service (optional, cloud specific)    | `""`        |
| `service.loadBalancerSourceRanges` | Address that are allowed when service is LoadBalancer | `[]`        |
| `service.externalTrafficPolicy`    | Enable client source IP preservation                  | `Cluster`   |
| `service.annotations`              | Annotations for stream service                       | `{}`        |


### stream Ingress configuration

| Name                            | Description                                                                                                                                                                                                                                                | Value           |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `ingress.enabled`               | Set to true to enable ingress record generation                                                                                                                                                                                                            | `false`         |
| `ingress.type`                  | Automatically configure your ingress for an ingress controller. Accepted values are nginx, traefik. This will override the clientCertificateHeader if set, and generate annotations, resources, and ingresses resources to ensure stream works correctly. | `""`            |
| `ingress.clientCertificateAuth` | When ingress.type is set, determines whether the ingress controller should request client certificates.                                                                                                                                                    | `false`         |
| `ingress.scepCompatibilityMode` | Adds a secondary ingress for SCEP support over HTTP                                                                                                                                                                                                        | `false`         |
| `ingress.ingressClassName`      | IngressClass that will be used to implement the Ingress (Kubernetes 1.18+)                                                                                                                                                                                 | `""`            |
| `ingress.hostname`              | Default host for the ingress resource                                                                                                                                                                                                                      | `stream.local` |
| `ingress.path`                  | Default path for the ingress record                                                                                                                                                                                                                        | `/`             |
| `ingress.pathType`              | Ingress path type                                                                                                                                                                                                                                          | `Prefix`        |
| `ingress.annotations`           | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.                                                                                                                           | `{}`            |
| `ingress.tls`                   | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                                                                                                                                            | `false`         |
| `ingress.extraHosts`            | The list of additional hostnames to be covered with this ingress record.                                                                                                                                                                                   | `[]`            |
| `ingress.extraPaths`            | An array with additional arbitrary paths that may need to be added to the ingress under the main host                                                                                                                                                      | `[]`            |
| `ingress.extraTls`              | The tls configuration for additional hostnames to be covered with this ingress record.                                                                                                                                                                     | `[]`            |
| `ingress.extraRules`            | Additional rules to be covered with this ingress record                                                                                                                                                                                                    | `[]`            |


### stream application parameters

| Name                      | Description                                                                                                                                                                                | Value                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- |
| `appSecret`               | Application secret used for encrypting session data and cookies                                                                                                                            | `{}`                                                                              |
| `license.secretName`      | Existing secret name where the stream license is stored                                                                                                                                   | `""`                                                                              |
| `license.secretKey`       | Existing secret key where the stream license is stored                                                                                                                                    | `""`                                                                              |
| `vaults`                  | stream vaults configuration                                                                                                                                                               | `[]`                                                                              |
| `vault.configuration`     | Name of the vault used for configuration purposes                                                                                                                                          | `default`                                                                         |
| `vault.escrow`            | Name of the vault used for escrowing purposes                                                                                                                                              | `default`                                                                         |
| `vault.transient`         | Name of the vault used for storing transient keys                                                                                                                                          | `default`                                                                         |
| `allowedHosts`            | Additional allowed hosts.                                                                                                                                                                  | `[]`                                                                              |
| `trustedProxies`          | Trusted proxies.                                                                                                                                                                           | `[]`                                                                              |
| `events.chainsign`        | Whether stream events should be signed and chained using the event seal secret.                                                                                                           | `true`                                                                            |
| `events.secret`           | Secret used to sign and chain events.                                                                                                                                                      | `{}`                                                                              |
| `events.ttl`              | Duration during which events are kept in database.                                                                                                                                         | `90 days`                                                                         |
| `events.discoveryTtl`     | Duration during which discovery events are kept in database.                                                                                                                               | `30 days`                                                                         |
| `mailer.host`             | SMTP host                                                                                                                                                                                  | `""`                                                                              |
| `mailer.port`             | SMTP host port                                                                                                                                                                             | `587`                                                                             |
| `mailer.tls`              | Enable TLS for this SMTP host                                                                                                                                                              | `true`                                                                            |
| `mailer.ssl`              | Enable SSL for this SMTP host                                                                                                                                                              | `false`                                                                           |
| `mailer.user`             | Authentication username for this SMTP host                                                                                                                                                 | `""`                                                                              |
| `mailer.password`         | Authentication password for this SMTP host                                                                                                                                                 | `{}`                                                                              |
| `logback.level`           | Global level below wich messages will not be logged                                                                                                                                        | `debug`                                                                           |
| `logback.pattern`         | Log messages pattern                                                                                                                                                                       | `%date{yyyy-MM-dd HH:mm:ss} - [%logger] - [%level] - %message%n%xException{full}` |
| `logback.loggers`         | Enabled loggers and their associated log level                                                                                                                                             | `[]`                                                                              |
| `leases.enabled`          | Whether leases should be used when launching multiple replicas of stream pods. This requires the leases.akka.io CRD to be installed.                                                      | `true`                                                                            |
| `clientCertificateHeader` | Indicates to stream in which header the client certificate will be passed. If not set, stream will try to guess the best parsing technique, depending on the ingress.type you specified. | `""`                                                                              |


### Database parameters

| Name                           | Description                                                                                                                                                                           | Value                                                                                                        |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `mongodb.enabled`              | Whether to deploy a mongodb server to satisfy the application database requirements. To use an external database set this to false and configure the `externalDatabase.uri` parameter | `true`                                                                                                       |
| `mongodb.architecture`         | MongoDB architecture (`standalone` or `replicaset`)                                                                                                                                   | `standalone`                                                                                                 |
| `mongodb.auth.rootPassword`    | MongoDB admin password                                                                                                                                                                | `""`                                                                                                         |
| `mongodb.auth.username`        | MongoDB custom user                                                                                                                                                                   | `stream`                                                                                                    |
| `mongodb.auth.database`        | MongoDB custom database                                                                                                                                                               | `stream`                                                                                                    |
| `mongodb.auth.password`        | MongoDB custom password                                                                                                                                                               | `secret_password`                                                                                            |
| `mongodb.stream.init`         | Set this to true to initialize the local database for stream. This only works when `mongodb.enabled` is set to true.                                                                 | `true`                                                                                                       |
| `mongodb.stream.username`     | Administration username used when initializing the database                                                                                                                           | `administrator`                                                                                              |
| `mongodb.stream.passwordHash` | Password hash used when initializing the database. Default: stream                                                                                                                   | `$6$8JDCzmb9XDpOwtGQ$7.kRdgIjPYR/AxPbzKsdkBH3ouCgFbqyH9csjcr5qIoIXK/f2L6bQYQRhi9sdQM4eBm8sGUdEkg.TVOQ1MRsA/` |


### Upgrade parameters

| Name                         | Description                                                                                                                                           | Value                   |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `upgrade.enabled`            | If true, an upgrade job will be run when upgrading the release, modifying your database schema. This works even if `mongodb.enabled` is set to false. | `true`                  |
| `upgrade.image.registry`     | stream image registry                                                                                                                                | `registry.evertrust.io` |
| `upgrade.image.repository`   | stream image repository                                                                                                                              | `stream-upgrade`       |
| `upgrade.image.tag`          | stream image tag (immutable tags are recommended)                                                                                                    | `2.3.0`                 |
| `upgrade.image.pullPolicy`   | stream image pull policy                                                                                                                             | `IfNotPresent`          |
| `upgrade.image.pullSecrets`  | stream image pull secrets                                                                                                                            | `[]`                    |
| `upgrade.resources.limits`   | The resources limits for the stream container                                                                                                        | `{}`                    |
| `upgrade.resources.requests` | The requested resources for the stream container                                                                                                     | `{}`                    |
| `upgrade.from`               | Sets to the version you're upgrading from. If empty, the chart will try to infer the version from the database.                                       | `""`                    |
| `upgrade.to`                 | Sets the version you're upgrading to. If empty, the chart will use Chart.AppVersion.                                                                  | `""`                    |
| `externalDatabase.uri`       | External MongoDB URI. For an external database to be used, `mongodb.enabled` must be set to `false`.                                                  | `{}`                    |


