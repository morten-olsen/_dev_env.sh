export NVM_DIR="$TOOLPATH/nvm"
if [ ! -d $TOOLPATH/nvm ]; then
  echo "Installing NVM"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nodeversion=$(nvm current)
if [ "$nodeversion" == "system" ]; then
  nvm install 9.4.0
  nvm use 9.4.0
  echo "Will change node to 9.4.0"
fi