#!/usr/bin/env sh

echo '🌐 Installing gcloud'

VERSION='421.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-$VERSION-darwin-arm.tar.gz?hl=es"
curl -o gcloud.tar.gz "$URL"

tar -zxvf gcloud.tar.gz

cp -R google-cloud-sdk $HOME/.gcloud

rm -rf google-cloud-sdk

rm gcloud.tar.gz

echo "Done!"
