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
      rm -rf "$PWD/.magicenv"
    ;;
    run)
    ;;
    help)
    ;;
    *)
      echo "No known command provided, use ./magicenv.sh help to see available commands"
      if [ "$IS_SOURCED" == "true" ]; then
        return
      else
        exit 1
      fi
    ;;
  esac
fi
unset called

ROOT=$PWD/.magicenv
if [ "_$AUTOENV_MODE" == "_ci" ]; then
  ROOT="$HOME/.magicenv"
  echo "Now running in CI mode"
fi

SCRIPTPATH=$ROOT/scripts
TOOLPATH=$ROOT/tools
DEPENDENCIES=()
VERSIONS=()
REPOSITORY="https://raw.githubusercontent.com/morten-olsen/magicenv/master/scripts"

mkdir -p $SCRIPTPATH
mkdir -p $TOOLPATH

download_script() {
  NAME="$1"
  TARGET="$SCRIPTPATH/$NAME.sh"
  if [ ! -f $TARGET ]; then
    echo "Fetching script for $NAME"
    URL=$REPOSITORY/$NAME.sh
    curl -o $SCRIPTPATH/$NAME.sh $URL
    # cp "./scripts/$NAME.sh" "$SCRIPTPATH/$NAME.sh"
  fi
}

install_dep() {
  DEPENDENCIES+=($1)
  VERSION="$2"
  if [ -z $2 ]; then
    VERSION="default"
  fi
  VERSIONS+=($VERSION)
}

tool_install_dep() {
  NAME=$1
  download_script "$NAME"
  source "$SCRIPTPATH/$NAME.sh"
}

init() {
  if [ "_$AUTOENV_IS_LOADED" == "_true" ]; then
    return
  fi
  if [ -f $PWD/magicenv.config.sh ]; then
    source $PWD/magicenv.config.sh
  fi
  for INDEX in ${!DEPENDENCIES[*]}
  do
    unset do_install
    NAME=${DEPENDENCIES[$INDEX]}
    VERSION=${VERSIONS[$INDEX]}
    download_script "$NAME"
    source "$SCRIPTPATH/$NAME.sh"
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
  unset SCRIPTPATH
  unset TOOLPATH
  unset DEPENDENCIES
  unset VERSIONS
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
      cat magicenv.md | mdless
    else
      less magicenv.md
    fi
  ;;
esac