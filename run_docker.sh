#!/usr/bin/env bash
# build the image
docker build --tag ml-predictor .

# List docker images
docker image ls

# Run flask app
docker run -d -p 8000:80 ml-predictor
