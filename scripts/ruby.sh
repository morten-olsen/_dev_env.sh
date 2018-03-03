export rvm_path="$TOOLPATH/rvm"
if [ ! -d $TOOLPATH/rvm ]; then
  echo "Installing RVM"
  curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
fi
source "$rvm_path/scripts/rvm"
rubyversion=$(rvm current)
if [ "$rubyversion" == "system" ]; then
  rvm install 2.5
  rvm use 2.5
  echo "Will change ruby to 2.5"
fi
if [ "_$(type mdless 2>/dev/null)" == "_" ]; then
  echo "Installing markdown support"
  gem install mdless
fi