export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

install_dep "ruby"
install_dep "node"
install_dep "python"
install_dep "xcode"
install_dep "android"
install_dep "go"
install_dep "hello"

function do_a_test() {
  echo "Hello"
}