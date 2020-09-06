#!/bin/bash

# Declare an array of images
export PROJ=mcnt
declare -a StringArray=("uix" "api" "worker")

echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_ID" --password-stdin

# Iterate the string array using for loop
for val in ${StringArray[@]}; do
    export img_name=$DOCKER_ID/$PROJ-$val
    docker build -t $img_name:latest -t $img_name:$VER_TAG ./$val
    docker push $img_name:latest
    docker push $img_name:$VER_TAG
done

##
## Deploying to kubectl
##
#kubectl apply -f k8s

##
## Applying latest version to containers 
##
#for val in ${StringArray[@]}; do
#    export img_name=$DOCKER_ID/$PROJ-$val
#    kubectl set image deployments/$val-deployment $val=$img_name:$VER_TAG
#done

