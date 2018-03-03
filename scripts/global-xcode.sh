do_install() {
  xcodeversion=$(/usr/bin/xcodebuild -version | head -n 1)
  if [ "_$xcodeversion" == "_Xcode $VERSION" ]; then
    return
  fi

  tool_install_dep "ruby"
  echo "Installing Xcode $VERSION"
  xcversion install "$VERSION"
}

get_default_version() {
  VERSION="9.2"
}