docker build -t rymunin/multi-client:latest -t rymunin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rymunin/multi-server:latest -t rymunin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rymunin/multi-worker:latest -t rymunin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rymunin/multi-client:latest
docker push rymunin/multi-server:latest
docker push rymunin/multi-worker:latest
docker push rymunin/multi-client:$SHA
docker push rymunin/multi-server:$SHA
docker push rymunin/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=rymunin/multi-server:$SHA
kubectl set image deployments/client-deployments client=rymunin/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=rymunin/multi-worker:$SHA