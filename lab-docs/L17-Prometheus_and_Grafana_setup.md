# Prometheus setup
### pre-requisites
1. Kubernetes cluster
2. helm

## Setup Prometheus

1. Create a dedicated namespace for prometheus 
   ```sh
   kubectl create namespace monitoring
   ```

2. Add Prometheus helm chart repository
   ```sh
   helm repo add prometheus-grafana-community https://prometheus-community.github.io/helm-charts 
   ```

3. Update the helm chart repository
   ```sh
   helm repo update
   helm repo list
   ```

4. pull the helm chart

 ```sh
  helm pull prometheus-grafana-community/kube-prometheus-stack
 ```

ls
       
# Now unzip
```sh
tar -xvzf kube-prometheus-stack-51.1.0.tgz
```

5. Install the prometheus

   ```sh
    helm install prometheus prometheus-grafana-community/kube-prometheus-stack --namespace monitoring
   ```
   
# check monitoring
```sh
kubectl get all -n monitoring
```

6. Above helm create all services as ClusterIP. To access Prometheus out side of the cluster, we should change the service type load balancer
   ```sh 
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring 
   ```
   
   ## change CluterIP to LoadBalancer

7. Loginto Prometheus dashboard to monitor application ec2 instance LoadBalancer
   https://ELB_dnsname:9090


8. Check for node_load15 executor to check cluster monitoring 


9. We check similar graphs in the Grafana dashboard itself. for that, we should change the service type of Grafana to LoadBalancer

```sh 
  kubectl edit svc prometheus-grafana -n monitoring
```

#change CluterIP to LoadBalancer
#kubectl get all -n monitoring


Loginto Grafana dashboard to monitor application ec2 instance LoadBalancer

   https://ELB_dnsname:80

10.  To login to Grafana account, use the below username and password 


```sh
    username: admin
    password: prom-operator
```


#Search or jump to..  kubernets/API server


11. Here we should check for "Node Exporter/USE method/Node" and "Node Exporter/USE method/Cluster"
    USE - Utilization, Saturation, Errors

   
12. Even we can check the behavior of each pod, node, and cluster 
