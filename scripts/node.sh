do_install() {
  export NVM_DIR="$DEVENV_TOOLPATH/nvm"
  if [ ! -d $DEVENV_TOOLPATH/nvm ]; then
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
  fi
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nodeversion=$(nvm current)
  if [ "$nodeversion" != "v$VERSION" ]; then
    nvm install "v$VERSION"
    nvm use "v$VERSION"
    echo "Will change node to $VERSION"
  fi
}

get_default_version() {
  VERSION="9.5.0"
}