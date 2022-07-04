#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`
# define the required environment variables, i.e DOCKER_HUB_USERNAME and DOCKER_HUB_PASSWORD
# or you can write each in a text file that is ignored for push to remote repositories, then cat the output as below
# dockerpath=$(cat username.txt)/housing-price-predictor
# Create dockerpath
dockerpath=${DOCKER_HUB_USERNAME}/housing-price-predictor
 
# Authenticate & tag
echo ${DOCKER_HUB_PASSWORD} | docker login --username ${DOCKER_HUB_USERNAME} --password-stdin
docker image tag ml-predictor $dockerpath
echo "Docker ID and Image: $dockerpath"

# Push image to a docker repository
docker image push $dockerpath

