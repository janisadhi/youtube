
# **Prometheus and Grafana Setup Documentation**

I wrote a script that automates the installation and configuration of Prometheus and Grafana in a Kubernetes environment. Here’s what I did:

### 1. **Ran the Setup Script**

I executed the setup script to install Prometheus and Grafana on my Kubernetes cluster by running the following command:

```bash
bash setup_prometheus_grafana.sh
```

This script automatically:
- Installed Helm (if it wasn’t already installed).
- Added the necessary Helm repositories for Prometheus and Grafana.
- Created a **monitoring** namespace in the cluster.
- Installed **Prometheus** and **Grafana** using Helm charts.
- Exposed the services via port forwarding.
- Displayed the URLs for accessing Prometheus and Grafana, along with the Grafana admin password.

### 2. **Accessed Prometheus and Grafana Dashboards**

Once the script finished running, I accessed the Prometheus and Grafana dashboards using the provided URLs:

- **Prometheus**: http://localhost:30004
- **Grafana**: http://localhost:30003

I logged into Grafana using the admin credentials provided in the script output.

### 3. **Check and Add Prometheus as a Data Source in Grafana**

To ensure Prometheus is set as a data source in Grafana, I checked the data sources configuration in Grafana. If Prometheus wasn’t already added, I followed these steps:

1. Log into Grafana (http://localhost:30003).
2. Go to **Configuration** → **Data Sources**.
3. Click **Add Data Source** → Select **Prometheus**.
4. In the **URL** field, set the value to:
   ```
   http://prometheus-kube-prometheus-prometheus.monitoring:9090
   ```
5. Click **Save & Test** to verify the connection.

### 4. **Imported Kubernetes Dashboards**

To monitor Kubernetes metrics in Grafana, I imported the relevant dashboards by following these steps:

1. Go to **Dashboards** in Grafana.
2. Click **Import**.
3. Use the dashboard IDs to import the following Kubernetes dashboards:
   - **Kubernetes Cluster Monitoring** → ID: **315**
   - **Kubernetes Node Exporter** → ID: **1860**

These dashboards will provide pre-configured visualizations for monitoring your Kubernetes cluster and node metrics.

### 5. **Viewed Kubernetes Pod Metrics on Grafana**

To view per-pod metrics like CPU, memory, and network usage, I followed these steps:

1. Go to **Dashboards** → **Kubernetes Pods Metrics** in Grafana.
2. Select a specific pod from the dropdown menu.
3. Monitor the following metrics:
   - **CPU Usage**: `container_cpu_usage_seconds_total`
   - **Memory Usage**: `container_memory_usage_bytes`
   - **Network Traffic**: `container_network_receive_bytes_total`

These metrics provide insights into the performance of individual pods in the cluster.

### 6. **Monitored Node & Cluster Health on Grafana**

To monitor the resource usage and health of the nodes and the cluster, I followed these steps:

1. Go to **Dashboards** → **Kubernetes Cluster Monitoring** in Grafana.
2. Check the following metrics for node health:
   - **Node CPU Usage**: `node_cpu_seconds_total`
   - **Node Memory Usage**: `node_memory_MemAvailable_bytes`
   - **Disk Usage**: `node_filesystem_avail_bytes`
   - **Pod Status**: `kube_pod_status_phase`

These metrics provide insights into the resource consumption of nodes in the cluster, disk usage, and the status of running pods.

### 7. **Set Up Alerts in Grafana**

To set up alerts for specific conditions, such as when CPU usage exceeds 80%, I followed these steps:

1. Go to **Grafana** → **Alerting** → **Create Alert Rule**.
2. Define the alert condition by setting the following expression:
   ```prometheus
   sum(rate(container_cpu_usage_seconds_total[5m])) by (pod) > 0.8
   ```
3. Set the desired notification channels (Slack, Email, PagerDuty, etc.).
4. Save the alert rule and enable it.

This will trigger an alert whenever the specified condition is met, such as high CPU usage.

### 8. **Edited the Grafana ConfigMap for SMTP Settings**

To enable email alerts, I edited the Grafana ConfigMap by running the following command:

```bash
KUBE_EDITOR='nano' kubectl edit configmap grafana -n monitoring
```

In the editor, I added the SMTP configuration to allow Grafana to send email alerts:

```ini
[smtp]
enabled = true
host = smtp.gmail.com:587
user = janisadhikari@gmail.com
password = ipij zgao dxxo ecec
from_address = grafana@example.com
from_name = Grafana Alerts
startTLS_policy = MandatoryStartTLS
```

I saved and exited the editor to apply the changes.

### 9. **Tested Email Alerts in Grafana**

I logged into Grafana and went to **Alerting > Contact Points**. There, I added my email address as a contact point and tested the email configuration. I received a confirmation email to the specified address, verifying that the SMTP setup was correct.

### 10. **Deleted and Restarted Grafana Pods**

After making changes to the Grafana configuration, I deleted the Grafana pods to apply the changes. I ran the following command to delete and restart the Grafana pods:

```bash
kubectl delete pod -l app.kubernetes.io/name=grafana -n monitoring
```

Kubernetes automatically restarted the pods to ensure everything was working correctly.

### 11. **Restarted Port Forwarding (if needed)**

If the terminal was closed or port forwarding stopped, I restarted port forwarding by running the following commands:

```bash
nohup kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 30004:9090 > /dev/null 2>&1 &
nohup kubectl port-forward svc/prometheus-grafana -n monitoring 30003:80 > /dev/null 2>&1 &
```

To stop port forwarding, I ran:

```bash
pkill -f "kubectl port-forward"
```

---

## **Customization Options**

- **Ports**: I customized the ports for Prometheus and Grafana by setting the `PROMETHEUS_PORT` and `GRAFANA_PORT` environment variables before running the script. For example:
  ```bash
  PROMETHEUS_PORT=30005 GRAFANA_PORT=30006 bash setup_prometheus_grafana.sh
  ```

- **SMTP Settings**: I edited the SMTP settings in the Grafana ConfigMap to match my email provider and credentials.

---

