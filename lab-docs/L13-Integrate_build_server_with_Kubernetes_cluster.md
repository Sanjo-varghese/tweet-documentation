## Integrate build server with Kubernetes cluster 

1. Setup kubectl   
   ```sh 
     curl -LO https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl
     chmod +x ./kubectl
     mv ./kubectl /usr/local/bin
     kubectl version
   ``` 

1. Make sure you have installed awscli latest version. If it has awscli version 1.X then remove it and install awscli 2.X  
    ```sh 
     yum remove awscli 
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    install unzip :apt install unzip
     unzip awscliv2.zip
     sudo ./aws/install --update
    ```

1. Configure awscli to connect with aws account  
    ```sh 
     aws configure
     Provide access_key, secret_key
    aws s3 ls
    ```

1. Download Kubernetes credentials and cluster configuration (.kube/config file) from the cluster  

   ```sh 
    aws eks update-kubeconfig --region us-east-2 --name SanJo-eks-cluster
   ```

  1. To Display Nodes

   ```sh
   kubectl get nodes
   ```

  1. To Display pods
  ```sh
   kubectl get pods
   ```
