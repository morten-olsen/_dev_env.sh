# _dev_env.sh

_** BEWARE **: This project is in an early state, as well is this documentation, both in language but also in information_

This is a dependency manager which tries to bridge the framework gap, as most dependency manager focuses on resolving dependencies for a given framework (npm, yarn, pip, bundle...). This depedency manager focuses instead on build tools, so this should be able to configure a fill developer environment.

All dependencies (except `xcode`) are installed local to the project and without touching any global configuartions, so there should be no chance of development environment cross contamination.

Currently supported dependencies:
* `nodejs@9.4.0`
* `ruby@2.5.0`
* `python@3.6.4`
* `android-sdk`
* `go@1.10`
* `global-xcode@9.2`
* `dotnet@2.1.4`
* `visual-studio-code` (experimental)

This project is still in an ealy stage, and at some point later on it should be possible to specify the required version, but for now versions are fixed

## Install

running `bash <(curl -sL https://goo.gl/g7frTq)` will download `_dev_env.sh`, `_dev_env.md` and `_dev_env.config.sh`

## Configure

All configuration is done inside `_dev_env.config.sh`
A lot more documentation will come, but for now an example of a development environment for a `react-native` app, which builds using `fastlane`

```shell
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

install_dep 'node'
install_dep 'ruby'
install_dep 'android-sdk'
install_dep 'global-xcode'

function ios() {
  bundle exec fastlane ios beta
}

function android() {
  bundle exec fastlane android beta
}

function setup() {
  bundle update
  npm install
  bundle exec fastlane match development
  bundle exec fastlane match adhoc
  bundle exec fastlane match appstore
}
```

With the above configuration to run the android version simply run `./_dev_env.sh run android`

## Working inside the environment

If you want to be able to run inside the environment, where all tools are available (this is for instance useful when installing new npm dependencies), it is possible to run `_dev_env.sh` as a dot script, which extends teh current shell session with all the dev tools which are installed `source _dev_env.sh`