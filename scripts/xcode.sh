xcodeversion=$(/usr/bin/xcodebuild -version | head -n 1)
if [ "_$xcodeversion" == "_Xcode 9.2" ]; then
  return
fi

tool_install_dep "ruby"
echo "Installing Xcode 9.2"
xcversion install 9.2