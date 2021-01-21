echo "install gcloud? y/n"
read INSTALL_GCLOUD

if [[ "$INSTALL_GCLOUD" == "y" ]]
then
  echo "Installing gcloud..."
  curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-323.0.0-darwin-x86_64.tar.gz --output google-cloud-sdk-323.0.0-darwin-x86_64.tar.gz
  tar -xvf google-cloud-sdk-323.0.0-darwin-x86_64.tar.gz -C ~
  ~/google-cloud-sdk/install.sh
  ~/google-cloud-sdk/bin/gcloud init
  rm google-cloud-sdk-323.0.0-darwin-x86_64.tar.gz
  echo "gcloud installed, RESTART terminal for use"
fi

echo "install firebase? y/n"
read INSTALL_FBASE

if [[ "$INSTALL_FBASE" == "y" ]]
then
  echo "Installing firebase..."
  curl -sL https://firebase.tools | bash
  echo "firebase installed"
fi
