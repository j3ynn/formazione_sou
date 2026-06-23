# Helm Values Override Exercise

## Overview

This exercise demonstrates how to override default Helm chart values using a custom values file.

A new file named `values-dev.yaml` was created inside the chart directory. The file contains only the values that need to be overridden, while all other settings continue to be inherited from the default `values.yaml`.

## Override File

```yaml
replicaCount: 2
```

## Installation Test

The chart was deployed using the custom values file:

```bash
helm install my-release ./chart -f values-dev.yaml
```

## Result

The default value defined in `values.yaml`:

```yaml
replicaCount: 1
```

was successfully overridden by the value defined in `values-dev.yaml`:

```yaml
replicaCount: 2
```

This confirms that Helm correctly merges and applies custom configuration values during deployment.
