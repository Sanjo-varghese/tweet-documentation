helm repo list
``sh
helm repo add bitnami https://charts.bitnami.com/bitnami
```
helm repo list

helm repo remove bitnami
```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Search the repository:
```sh
helm search repo mysql

helm search repo database

helm search repo database --versions
```

Install a package:

kubectl get pods

(Below Two commands - In a Different Shell/Commandline window/tab)

minikube ssh

docker images
```sh
helm install mydb bitnami/mysql
```
Check the cluster:

kubectl get pods

minikube ssh

docker images

To check the installation status:
```sh
helm status mydb
```


--------------------------------------------

To Upgrade:
```s
ROOT_PASSWORD=$(kubectl get secret --namespace default mydb-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode)

helm upgrade --namespace default mysql-release bitnami/mysql --set auth.rootPassword=$ROOT_PASSWORD
```
-------

To Uninstall 
```sh
helm uninstall mysql-release
```