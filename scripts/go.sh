do_install() {
  export GOROOT=$DEVENV_TOOLPATH/go
  export PATH=$PATH:$GOROOT/bin
  if [ ! -d $DEVENV_TOOLPATH/go/bin ]; then
    mkdir -p $DEVENV_TOOLPATH/go
    echo "Installing GO"
    # TODO: Change for non darwin, to use linux version
    curl https://dl.google.com/go/go1.10.darwin-amd64.tar.gz -o $DEVENV_TOOLPATH/go.tar.gz
    pushd $DEVENV_TOOLPATH
    tar -xf $DEVENV_TOOLPATH/go.tar.gz
    rm $DEVENV_TOOLPATH/go.tar.gz
    popd
  fi
}

get_default_version() {
  VERSION="one-size"
}