do_install() {
  PYTHON_ROOT=$TOOLPATH/python
  mkdir -p $PYTHON_ROOT
  if [ ! -d $PYTHON_ROOT/pyenv-1.2.2 ]; then
    echo "Installing Python" 
    mkdir -p $PYTHON_ROOT
    curl https://github.com/pyenv/pyenv/archive/v1.2.2.zip -L -o $PYTHON_ROOT/python.zip
    pushd $PYTHON_ROOT
    unzip python.zip
    rm python.zip
    popd
  fi
  export PYENV_ROOT="$DEVENV_TOOLPATH/python/pyenv-1.2.2"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  pythonversion=$(pyenv global)
  if [ "$pythonversion" == "system" ]; then
    pyenv install $VERSION
    pyenv global $VERSION
    echo "Will change python to $VERSION"
  fi
}

get_default_version() {
  VERSION="3.6.4"
}