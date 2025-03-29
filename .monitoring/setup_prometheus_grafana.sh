#!/bin/bash

# Add Prometheus Helm repository
echo "Adding Prometheus Helm repository..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Add Grafana Helm repository
echo "Adding Grafana Helm repository..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Create the monitoring namespace if it doesn't exist
echo "Creating monitoring namespace..."
kubectl create namespace monitoring || echo "Namespace 'monitoring' already exists."

# Install Prometheus in the monitoring namespace
echo "Installing Prometheus..."
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring

# Install Grafana in the monitoring namespace
echo "Installing Grafana..."
helm install grafana grafana/grafana --namespace monitoring

# Wait for the Grafana pod to be deployed (optional)
echo "Waiting for Grafana to be deployed..."
kubectl rollout status deployment/grafana --namespace monitoring

# Get the Grafana admin credentials
echo "Retrieving Grafana admin credentials..."

# Get the default admin username (Grafana's default is 'admin')
admin_username="admin"

# Get the secret for Grafana password
grafana_secret=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

# Show the username and password
echo "Grafana Username: $admin_username"
echo "Grafana Password: $grafana_secret"

echo "Installation of Prometheus and Grafana completed."
echo "You can access Grafana at http://localhost:30004"
echo "You can access Prometheus at http://localhost:30003"