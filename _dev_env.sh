#!/usr/bin/env bash

called=$_
[[ $called != $0 ]] && IS_SOURCED="true" || IS_SOURCED="false"
if [ -z $1 ]; then
  if [ "$IS_SOURCED" == "false" ]; then
    echo "Running without params is reserved for sourcing"
    exit
  fi
else
  case $1 in
    clean)
      rm -rf "$PWD/._dev_env"
    ;;
    run)
    ;;
    help)
    ;;
    *)
      echo "No known command provided, use ./_dev_env.sh help to see available commands"
      if [ "$IS_SOURCED" == "true" ]; then
        return
      else
        exit 1
      fi
    ;;
  esac
fi
unset called

ROOT="$PWD/._dev_env"
if [ "_$DEVENV_MODE" == "_ci" ]; then
  ROOT="$HOME/._dev_env"
  echo "Now running in CI mode"
fi

DEVENV_SCRIPTPATH=$ROOT/scripts
DEVENV_TOOLPATH=$ROOT/tools
DEVENV_TMPPATH=$ROOT/tmp
DEVENV_DEPENDENCIES=()
DEVENV_VERSIONS=()
DEVENV_REPOSITORY="https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/scripts"

mkdir -p $DEVENV_SCRIPTPATH
mkdir -p $DEVENV_TOOLPATH
mkdir -p $DEVENV_TMPPATH

download_script() {
  NAME="$1"
  TARGET="$DEVENV_SCRIPTPATH/$NAME.sh"
  if [ ! -f $TARGET ]; then
    echo "Fetching script for $NAME"
    URL=$DEVENV_REPOSITORY/$NAME.sh
    # curl -o $DEVENV_SCRIPTPATH/$NAME.sh $URL
    cp "./scripts/$NAME.sh" "$DEVENV_SCRIPTPATH/$NAME.sh"
  fi
}

install_dep() {
  DEVENV_DEPENDENCIES+=($1)
  VERSION="$2"
  if [ -z $2 ]; then
    VERSION="default"
  fi
  DEVENV_VERSIONS+=($VERSION)
}

tool_install_dep() {
  NAME=$1
  download_script "$NAME"
  source "$DEVENV_SCRIPTPATH/$NAME.sh"
}

init() {
  if [ "_$AUTOENV_IS_LOADED" == "_true" ]; then
    return
  fi
  if [ -f $PWD/_dev_env.config.sh ]; then
    source $PWD/_dev_env.config.sh
  fi
  for INDEX in ${!DEVENV_DEPENDENCIES[*]}
  do
    unset do_install
    NAME=${DEVENV_DEPENDENCIES[$INDEX]}
    VERSION=${DEVENV_VERSIONS[$INDEX]}
    download_script "$NAME"
    source "$DEVENV_SCRIPTPATH/$NAME.sh"
    if [ $VERSION == "default" ]; then
      unset VERSION
      get_default_version
    fi
    do_install $VERSION
  done
  export AUTOENV_IS_LOADED="true"
}

cleanup() {
  unset download_script
  unset install_dep
  unset init
  unset do_install
  unset get_default_version
  unset cleanup
  unset DEVENV_SCRIPTPATH
  unset DEVENV_TOOLPATH
  unset DEVENV_DEPENDENCIES
  unset DEVENV_VERSIONS
  unset VERSION
  unset NAME
  unset ROOT
}

init
cleanup

case $1 in
  run)
    $2
  ;;
  help)
    if [ ! "_$(type mdless 2>/dev/null)" == "_" ]; then
      if [ -f _dev_env.md ]; then
        cat _dev_env.md | mdless
      else
        curl -L "https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/README.md" | mdless
      fi
    else
      if [ -f _dev_env.md ]; then
        less _dev_env.md
      else
        curl -L "https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/README.md" | less
      fi
    fi
  ;;
esac