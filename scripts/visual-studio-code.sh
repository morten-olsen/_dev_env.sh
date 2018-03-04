do_install() {
  if [ ! -f $DEVENV_TOOLPATH/vscode/code ]; then
    echo "Installing Visual Studio Code"
    curl https://go.microsoft.com/fwlink/?LinkID=620882 -L -o $DEVENV_TMPPATH/vscode.zip
    mkdir -p $DEVENV_TOOLPATH/vscode
    pushd $DEVENV_TOOLPATH/vscode
    unzip $DEVENV_TMPPATH/vscode.zip
    rm $DEVENV_TMPPATH/vscode.zip
    ln -s $DEVENV_TOOLPATH/vscode/Visual\ Studio\ Code.app/Contents/MacOS/Electron $DEVENV_TOOLPATH/vscode/code
    popd
  fi
  export PATH=$DEVENV_TOOLPATH/vscode:$PATH
}

get_default_version() {
  VERSION="one-size"
}