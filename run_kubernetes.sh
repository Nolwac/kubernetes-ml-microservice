#!/usr/bin/env bash

# This deploys and image with kubernetes

# This is your Docker ID/path
dockerpath=nolwac/housing-price-predictor


# Run the Docker Hub container with kubernetes
# kubectl run predictor-app --image=$dockerpath --port=80
kubectl create deployment predictor-app --image=$dockerpath

# List kubernetes pods
kubectl get pods

# Forward the container port to a host
kubectl port-forward deployment/predictor-app 8080:80


