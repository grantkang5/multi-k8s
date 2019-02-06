docker build -t grant05/multi-client:latest -t grant05/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grant05/multi-server:latest -t grant05/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grant05/multi-worker:latest -t grant05/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push grant05/multi-client:latest
docker push grant05/multi-server:latest
docker push grant05/multi-worker:latest

docker push grant05/multi-client:$SHA
docker push grant05/multi-server:$SHA
docker push grant05/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=grant05/multi-server:$SHA
kubectl set image deployments/client-deployment client=grant05/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grant05/multi-worker:$SHA