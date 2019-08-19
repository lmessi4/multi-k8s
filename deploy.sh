#!/bin/bash

# building docker images.
docker build -t walidghallab/multi-client:latest -t walidghallab/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t walidghallab/multi-server:latest -t walidghallab/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t walidghallab/multi-worker:latest -t walidghallab/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

# pushing docker images to docker hub
docker push walidghallab/multi-client:latest
docker push walidghallab/multi-server:latest
docker push walidghallab/multi-worker:latest
docker push walidghallab/multi-client:$GIT_SHA
docker push walidghallab/multi-server:$GIT_SHA
docker push walidghallab/multi-worker:$GIT_SHA


kubectl apply -f k8s
kubectl set image deployment/client-deployment client=walidghallab/multi-client:$GIT_SHA
kubectl set image deployment/server-deployment server=walidghallab/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment worker=walidghallab/multi-worker:$GIT_SHA
