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
export PYENV_ROOT="$TOOLPATH/python/pyenv-1.2.2"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pythonversion=$(pyenv global)
if [ "$pythonversion" == "system" ]; then
  pyenv install 3.6.4
  pyenv global 3.6.4
  echo "Will change python to 3.6.4"
fi