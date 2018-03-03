do_install() {
  export GOROOT=$TOOLPATH/go
  export PATH=$PATH:$GOROOT/bin
  if [ ! -d $TOOLPATH/go/bin ]; then
    mkdir -p $TOOLPATH/go
    echo "Installing GO"
    # TODO: Change for non darwin, to use linux version
    curl https://dl.google.com/go/go1.10.darwin-amd64.tar.gz -o $TOOLPATH/go.tar.gz
    pushd $TOOLPATH
    tar -xf $TOOLPATH/go.tar.gz
    rm $TOOLPATH/go.tar.gz
    popd
  fi
}

get_default_version() {
  VERSION="one-size"
}