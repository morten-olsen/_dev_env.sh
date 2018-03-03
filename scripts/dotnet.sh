export PATH=$TOOLPATH/dotnet:$PATH
if [ ! -f $TOOLPATH/dotnet/dotnet ]; then
  mkdir -p $TOOLPATH/dotnet
  echo "Installing .NET Core"
  # TODO: Change for non darwin, to use linux version
  curl https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-osx-x64.tar.gz -o $TOOLPATH/dotnet/dotnet.tar.gz
  pushd $TOOLPATH/dotnet
  tar -xf $TOOLPATH/dotnet/dotnet.tar.gz
  rm $TOOLPATH/dotnet/dotnet.tar.gz
  popd
fi