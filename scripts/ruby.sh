do_install() {
  export rvm_path="$TOOLPATH/rvm"
  if [ ! -f $rvm_path/scripts/rvm ]; then
    rm -rf $rvm_path
    echo "Installing RVM"
    curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
  fi
  source "$rvm_path/scripts/rvm"
  rubyversion=$(rvm current)
  if [ "$rubyversion" != "ruby-$VERSION" ]; then
    rvm install $VERSION
    rvm use $VERSION
    echo "Will change ruby to $VERSION"
  fi
  if [ "_$(type mdless 2>/dev/null)" == "_" ]; then
    echo "Installing markdown support"
    gem install mdless
  fi
}

get_default_version() {
  VERSION="2.5.0"
}