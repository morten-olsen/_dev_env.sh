#!/usr/bin/env bash

ROOT=$PWD/.magicenv
if [ "_$AUTOENV_MODE" == "_ci" ]; then
  ROOT="$HOME/.magicenv"
  echo "Now running in CI mode"
fi

SCRIPTPATH=$ROOT/scripts
TOOLPATH=$ROOT/tools
DEPENDENCIES=()
DEPENDENCIES=()
REPOSITORY="https://raw.githubusercontent.com/morten-olsen/magicenv/master/scripts"

mkdir -p $SCRIPTPATH

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
  for NAME in "${DEPENDENCIES[@]}"
  do
    download_script "$NAME"
    source "$SCRIPTPATH/$NAME.sh"
  done
  export AUTOENV_IS_LOADED="true"
}

init

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