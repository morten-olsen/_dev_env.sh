export ANDROID_HOME=$TOOLPATH/android
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
if [ ! -d $ANDROID_HOME/tools ]; then
  echo "Installing Android"
  # TODO: Change for non darwin, to use linux version
  curl https://dl.google.com/android/repository/sdk-tools-darwin-3859397.zip -o android.zip
  mkdir -p $ANDROID_HOME
  mv android.zip $ANDROID_HOME
  pushd $ANDROID_HOME
  unzip android.zip
  rm android.zip
  popd
fi
if [ ! -f $ANDROID_HOME/licenses/android-sdk-license ]; then
  mkdir -p $ANDROID_HOME/licenses
  echo "\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license
fi