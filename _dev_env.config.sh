export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# install_dep "ruby"
# install_dep "node" "9.5.0"
# install_dep "python"
# install_dep "global-xcode"
# install_dep "android-sdk"
# install_dep "go"
# install_dep "hello"
install_dep "dotnet"

# install_dep "visual-studio-code"

function do_a_test() {
  echo "Hello"
}

function dotnet_version() {
  dotnet build
  which dotnet
}