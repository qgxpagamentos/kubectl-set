#!/bin/bash

set -v # show current command

mkdir $GITHUB_WORKSPACE/bin

echo "KUBE_VERSION: $KUBE_VERSION"

# kubectl
curl -LO "https://dl.k8s.io/release/$KUBE_VERSION/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$KUBE_VERSION/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
chmod +x kubectl

# aws-iam-authenticator
curl -LO "https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator"
chmod +x aws-iam-authenticator

# moving
mv kubectl /usr/local/bin/kubectl
mv aws-iam-authenticator $GITHUB_WORKSPACE/bin

echo "$GITHUB_WORKSPACE/bin" >> $GITHUB_PATH

if [ ! -d "$HOME/.kube" ]; then
	mkdir -p $HOME/.kube
fi

echo "$BASE64_KUBE_CONFIG" | base64 -d > $HOME/.kube/config
