#!/bin/bash

##
## Declare an array of images
export PROJ=mcnt
declare -a StringArray=("uix" "api" "worker")

echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_ID" --password-stdin

##
## Iterate the string array using for loop
echo "Building production images..."
for val in ${StringArray[@]}; do
    echo "Building production image for: "$val
    export img_name=$DOCKER_ID/$PROJ-$val
    docker build -t $img_name:latest -t $img_name:$VER_TAG ./$val
    echo "Pushing latest image for: "$val
    docker push $img_name:latest
    echo "Pushing image: "$val":"$VER_TAG
    docker push $img_name:$VER_TAG
done

##
echo "Deploying to kube..."
##
#kubectl apply -f k8s

##
echo "Applying latest version to containers..."
##
#for val in ${StringArray[@]}; do
#    export img_name=$DOCKER_ID/$PROJ-$val
#    kubectl set image deployments/$val-deployment $val=$img_name:$VER_TAG
#done

