### Simple nginx pod creation and exposing to internet

```text
docker build -t santoshr1016/nginx .
docker push santoshr1016/nginx

Deploy the Pod
k run nginx --image=santoshr1016/nginx:latest --restart=Never 

Expose the Pod
k expose pod nginx --port=80 --type=NodePort --name=nginx-svc

Get the Node port 
k get svc nginx-svc -o wide


Check the worker node public ip
k get nodes -o wide

View the webpage
WORKER_NODE_IP_ADDR:NODE_PORT
```
