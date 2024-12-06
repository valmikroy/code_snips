# K8S Notes

Document to note down minikube setup and related experimentation.



## Install minikube

```
sudo apt update
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
```







## Access local minikube with openlens

To make things simplfy we would like to install docker driver with minikube cluster on the local linux server.  So we can use docker driver and standard docker images without podman.

Our local linux server IP is `10.0.0.1` for this documentation purposes

 [Document](https://www.chevdor.com/post/2021/02/docker_to_k8s/) refered for this setup



Clean up and create minikube cluster with API servers exposed to server IP

```
minikube delete
minikube start --apiserver-ips="10.0.0.1"
minikube start --apiserver-ips=`ip -f inet addr show enp2s0 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'`
```

Following docker command can confirm that API management port `8443` has been up.

```
$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS          PORTS                                                                                                                                  NAMES
ba7891307d65   gcr.io/k8s-minikube/kicbase:v0.0.42   "/usr/local/bin/entr…"   23 seconds ago   Up 22 seconds   127.0.0.1:32782->22/tcp, 127.0.0.1:32781->2376/tcp, 127.0.0.1:32780->5000/tcp, 127.0.0.1:32779->8443/tcp, 127.0.0.1:32778->32443/tcp   minikube
```

You can get the local minikube IP to which the above port is forwarded by the docker container

``` 
$ minikube ip
192.168.49.2
```

Then come to your Mac desktop where you want to run openlens and from where you can do ssh to the local linux server. Forward the API management port `192.168.49.2:8443`  while sshing to the local linux server from the Mac desktop's `18443` port.

```
ssh -N -p 22 10.0.0.1 -L 127.0.0.1:18443:192.168.49.2:8443
```

Transfer certificate files created by minikube on the linux server to your Mac desktop under `.minikube` dir 

```
~/.minikube/profiles/minikube/client.{key,crt} 
~/.minikube/ca.crt 


scp <linuxserver>:~/.minikube/profiles/minikube/client.{crt,key} ~/.minikube/
scp <linuxserver>:~/.minikube/profiles/minikube/ca.crt ~/.minikube/

```

Run the following `kubectl` commands to setup the configuration environment on Mac dekstop



The following should create cluster entry in the config

```
kubectl config set-cluster minikube \
	--server https://127.0.0.1:18443 \
	--certificate-authority=/Users/<login>/.minikube/ca.crt \
	--kubeconfig ~/.minikube/config  
```



Create credentials

```
kubectl config set-credentials minikube \
	--client-certificate=/Users/<login>/.minikube/client.crt \
	--client-key=/Users/<login>/.minikube/client.key  \
	--kubeconfig ~/.minikube/config  
```



Create a context 

```
kubectl config set-context minikube 
	--cluster=minikube \
	--namespace=default \
	--user=minikube  \
	--kubeconfig ~/.minikube/config

kubectl config get-contexts --kubeconfig ~/.minikube/config
```



After this you can read the minikube config in openlens to operate on the minikube cluster



## Run your own docker registary 

Tired of fetching from docker and depending on pushing experimental containers to push there. Running docker registary 

```
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

add the entry for http only access in `/etc/docker/daemon.json`

```
{ 
"insecure-registries":[
		"registry1:80",
		"registry2:458"
	] 
}
```



Restart docker

```
 systemctl restart docker
```



You need to turn on Avahi for auto discovery of the hostname, minor uncommenting in the config file `/etc/avahi/avahi-daemon.conf` and restart

```
 sudo service avahi-daemon restart
```



Document referance for docker local registary is [here](https://www.allisonthackston.com/articles/local-docker-registry.html)



Also to make minikube to use local insecure repositor 

```
minikube start \
	--apiserver-ips=`ip -f inet addr show enp2s0 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'`  \
	--insecure-registry="<linux_server>:5000" \
	--addons=ingress
```



You might want to delete the old minikube cluster to make sure the above insecure registry access works fine. 







### Grafana install 

```
kubectl get crd
```



```
 kubectl get secret --namespace soat-grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```











