#!/usr/bin/env bash
# Prints OK or MISSING for each tool used in the Real-World DevOps Projects series.
for t in brew git docker kubectl kind minikube helm terraform tflint aws python3 node npm jq yq make trivy hadolint localstack ansible; do
  if command -v "$t" >/dev/null 2>&1; then
    printf "%-12s OK   %s\n" "$t" "$(command -v "$t")"
  else
    printf "%-12s MISSING\n" "$t"
  fi
done
