# magicenv.sh

_** BEWARE **: This project is in an early state, as well is this documentation, both in language but also in information_

This is a dependency manager which tries to bridge the framework gap, as most dependency manager focuses on resolving dependencies for a given framework (npm, yarn, pip, bundle...). This depedency manager focuses instead on build tools, so this should be able to configure a fill developer environment.

All dependencies (except `xcode`) are installed local to the project and without touching any global configuartions, so there should be no chance of development environment cross contamination.

Currently supported dependencies:
* `nodejs@9.4.0`
* `ruby@2.5.0`
* `python@3.6.4`
* `android-sdk`
* `go@1.10`
* `xcode@9.2`

This project is still in an ealy stage, and at some point later on it should be possible to specify the required version, but for now versions are fixed

## Install

running `bash <(curl -sL https://goo.gl/g7frTq)` will download `magicenv.sh`, `magicenv.md` and `magicenv.config.sh`

## Configure

All configuration is done inside `magicenv.config.sh`
A lot more documentation will come, but for now an example of a development environment for a `react-native` app, which builds using `fastlane`

```shell
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

install_dep 'node'
install_dep 'ruby'
install_dep 'android'
install_dep 'xcode'

function ios() {
  npx react-native run-ios
}

function android() {
  npx react-native run-android
}
```

With the above configuration to run the android version simply run `./magicenv.sh run android`

## Working inside the environment

If you want to be able to run inside the environment, where all tools are available (this is for instance useful when installing new npm dependencies), it is possible to run `magicenv.sh` as a dot script, which extends teh current shell session with all the dev tools which are installed `source magicenv.sh`