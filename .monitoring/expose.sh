#!/bin/bash

# Function to kill any process running on a specific port
kill_process_on_port() {
  port=$1
  echo "Checking for any process running on port $port..."

  # Get the process ID (PID) of the application running on the port
  pid=$(lsof -t -i:$port)

  if [ -n "$pid" ]; then
    echo "Killing process with PID $pid running on port $port..."
    kill -9 $pid
  else
    echo "No process found running on port $port."
  fi
}

# Kill any application running on port 30003
kill_process_on_port 30003

# Kill any application running on port 30004
kill_process_on_port 30004

# Expose Prometheus service to port 30003
echo "Exposing Prometheus to port 30003..."
kubectl port-forward svc/prometheus-kube-prometheus-prometheus 30003:9090 --namespace monitoring &

# Expose Grafana service to port 30004
echo "Exposing Grafana to port 30004..."
kubectl port-forward svc/grafana 30004:80 --namespace monitoring &

# Wait for a moment to ensure the services are being exposed in the background
sleep 2

# Check if the services are exposed
if lsof -i :30003 > /dev/null && lsof -i :30004 > /dev/null; then
  echo "Prometheus and Grafana are now exposed on ports 30003 and 30004, running in the background."
else
  echo "Failed to expose Prometheus and Grafana on the desired ports."
fi
