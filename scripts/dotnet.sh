do_install() {
  export PATH=$DEVENV_TOOLPATH/dotnet:$PATH
  if [ ! -f $DEVENV_TOOLPATH/dotnet/dotnet ]; then
    mkdir -p $DEVENV_TOOLPATH/dotnet
    echo "Installing .NET Core"
    # TODO: Change for non darwin, to use linux version
    curl https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-osx-x64.tar.gz -o $DEVENV_TOOLPATH/dotnet/dotnet.tar.gz
    pushd $DEVENV_TOOLPATH/dotnet
    tar -xf $DEVENV_TOOLPATH/dotnet/dotnet.tar.gz
    rm $DEVENV_TOOLPATH/dotnet/dotnet.tar.gz
    popd
  fi
}

get_default_version() {
  VERSION="2.1.4"
}