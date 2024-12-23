#!/bin/bash
if [ $# -eq 0 ]
then

  if [ ! -f go.mod ]
  then
    cd /common && go mod download -x && cd /app
    go mod init github.com/entigolabs/entigo-infralib
    go mod edit -require github.com/entigolabs/entigo-infralib-common@v0.0.0 -replace github.com/entigolabs/entigo-infralib-common=/common
    go mod tidy
  fi
  if [ "$ENTIGO_INFRALIB_KUBECTL_EKS_CONTEXTS" == "true" ]
  then
    aws eks update-kubeconfig --region $AWS_REGION --name runner-main-biz
    if [ $? -ne 0 ]
    then
      echo "Failed to configure runner-main-biz EKS context"
      exit 1
    fi
    aws eks update-kubeconfig --region $AWS_REGION --name runner-main-pri
    if [ $? -ne 0 ]
    then
      echo "Failed to configure runner-main-pri EKS context"
      exit 2
    fi
    kubectl get ns kube-system --context arn:aws:eks:eu-north-1:877483565445:cluster/runner-main-biz
    if [ $? -ne 0 ]
    then
      echo "Failed to connect to runner-main-biz EKS k8s cluster"
      exit 3
    fi
    kubectl get ns kube-system --context arn:aws:eks:eu-north-1:877483565445:cluster/runner-main-pri
    if [ $? -ne 0 ]
    then
      echo "Failed to connect to runner-main-pri EKS k8s cluster"
      exit 4
    fi
  fi

  if [ "$ENTIGO_INFRALIB_KUBECTL_GKE_CONTEXTS" == "true" ]
    then

      gcloud container clusters get-credentials runner-main-biz --region $GOOGLE_REGION
      if [ $? -ne 0 ]
      then
        echo "Failed to configure runner-main-biz GKE context"
        exit 1
      fi
      gcloud container clusters get-credentials runner-main-pri --region $GOOGLE_REGION
      if [ $? -ne 0 ]
      then
        echo "Failed to configure runner-main-pri GKE context"
        exit 2
      fi
      kubectl get ns kube-system --context gke_entigo-infralib2_europe-north1_runner-main-biz
      if [ $? -ne 0 ]
      then
        echo "Failed to connect to runner-main-biz GKE k8s cluster"
        exit 3
      fi
      kubectl get ns kube-system --context gke_entigo-infralib2_europe-north1_runner-main-pri
      if [ $? -ne 0 ]
      then
        echo "Failed to connect to runner-main-pri GKE k8s cluster"
        exit 4
      fi
    fi
  
  cd test && go test -timeout $ENTIGO_INFRALIB_TEST_TIMEOUT
  exit $?
fi
exec $@
