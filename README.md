# Kubernetes Deployable Housing Price Machine Learning Based Predictor.

[![Nolwac](https://circleci.com/gh/Nolwac/kubernetes-ml-microservice.svg?style=svg)](https://circleci.com/gh/Nolwac/kubernetes-ml-microservice)

## Project Overview

This project is a Machine Learning project to predict housing price. The project has been build to a [docker image](https://hub.docker.com/repository/registry-1.docker.io/nolwac/housing-price-predictor/general) which can easily be deployed as microservice in Kubernetes or Docker, using a **YAML** configuration file and/(or only) **kubectl or docker** command line utility respectively. Once deployed, the service exposes an endpoint which prediction calls can be made to.

## Running the Prediction Service

To run the project, a Makefile has been added which contains the basic commands needed to setup the environment running.
**Note**: *it is reccommended that you run the project on a linux system or pull the image from docker hub to run in Kubernetes or Docker. You may as well follow the steps discussed later in this docs to build the docker image yourself.*

**Every commands listed here should be executed from the project's root directory** 

### Running it as a Standalone app
To run it as standalone app, you have to create a virtual environment by running the **make** command below:

**For Linux**
```bash
make setup
source ~/.devops/bin/activate
make install
python app.py
```

**For Windows**
```cmd
python -m venv /.devops
/.devops/Scripts/activate
make install
python app.py
```
### Running with Docker
First you have to make sure that you have docker installed and running, then run the *run_docker.sh* bash script as below:
```bash
./run_docker.sh
```
If it throws a permission denied error, change the mode to executable using the command below
```bash
chmod +x run_docker.sh
```
You may have to do this as a root user for this to work.

### Running with Kubernetes
First you have to make sure that Kubernetes and *kubectl* command line utility are installed and well configured.
Then, run the command below:
```bash
./run_kubernetes.sh
```
The *run_kubernetes.sh* bash script will pull the existing image from docker hub, run the image in Kubernetes, list the pods available as a display of the success of the command, and finally forward a port to the host machine for previewing the result.

If you get a line saying, *cannot forward port because pod is not running, status is pending*, then you will have to wait for the pod to start running. Verify pod status using `kubectl get pods` command. Once the pod is running, you can execute the command again, then go to the URL [http://localhost:8000](http://localhost:8000) to preview the result and to start making predictions.

*Alternatively, you can use a YAML code to deploy the service in Kubernetes or Docker Swarm*

### Making Predictions
Once the service running, then you can make a call to the endpoint with a payload containg the features data for which prediction is to be made. Example can be seen below:
```bash
curl -d '{  
   "CHAS":{  
      "0":0
   },
   "RM":{  
      "0":6.575
   },
   "TAX":{  
      "0":296.0
   },
   "PTRATIO":{  
      "0":15.3
   },
   "B":{  
      "0":396.9
   },
   "LSTAT":{  
      "0":4.98
   }
}'\
     -H "Content-Type: application/json" \
     -X POST http://localhost:8000/predict
```
Alternatively, you could look into *make_prediction.sh* bash script and edit the feature values to make your predictions.

## How it works
The Algorithm is a pretrained model. The model data and the pretrained model can be found in *model_data* directory.
Inside *app.py* is a **Flask** app definition that service the prediction model on an endpoint when called.

## CI/CD
This project integrates **CircleCI** for CI/CD. The CircleCI configuration file, *config.yml* can be found inside *.circleci* directory. That's the file CircleCI looks into for instructions on what to do in the Pipeline.

As you may have notice, at the topmost level of this docs, just after the title is a CircleCI badge, which displays the current status of the Pipeline build. Here it is again.

[![Nolwac](https://circleci.com/gh/Nolwac/kubernetes-ml-microservice.svg?style=svg)](https://circleci.com/gh/Nolwac/kubernetes-ml-microservice)