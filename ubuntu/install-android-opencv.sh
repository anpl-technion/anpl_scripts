#!/bin/bash

ANPL_DIR=~/ANPL
PROJECT_DIR=android
MODULE_DIR=$PROJECT_DIR/src/sensors
OPENCV_DIR_NAME=opencv3
OPENCV_VER="3.0.0-rc1"
OPENCV_VER_CODE="${OPENCV_VER//[.a-z-]}0"
ANDROID_TOOL_VERSION="1.2.3"

#from http://blog.hig.no/gtl/2014/08/28/opencv-and-android-studio/
#downlaod opencv android sdk
cd ~/Downloads
wget -O OpenCV-android-sdk.zip "http://garr.dl.sourceforge.net/project/opencvlibrary/opencv-android/$OPENCV_VER/OpenCV-$OPENCV_VER-android-sdk.zip"
#from http://unix.stackexchange.com/questions/59276/how-to-extract-only-a-specific-folder-from-a-zipped-archive-to-a-given-directory
unzip OpenCV-android-sdk.zip "OpenCV-android-sdk/sdk/java/*" -d ~/Downloads
mv OpenCV-android-sdk/sdk/java . 
rm -rf OpenCV-android-sdk.zip OpenCV-android-sdk
mv java  $OPENCV_DIR_NAME
rm -rf ${ANPL_DIR}/$MODULE_DIR/$OPENCV_DIR_NAME
mv $OPENCV_DIR_NAME ${ANPL_DIR}/$MODULE_DIR
cd ${ANPL_DIR}/$MODULE_DIR/$OPENCV_DIR_NAME

#create build.gradle
cat << EOF > build.gradle

apply plugin: "ros-android"
apply plugin: 'com.android.library'

group 'org'
version = "$OPENCV_VER"

buildscript {
  repositories {
    mavenCentral()
  }
  dependencies {
    classpath "com.android.tools.build:gradle:$ANDROID_TOOL_VERSION"
  }
}

android {
  compileSdkVersion 21
  buildToolsVersion "21.1.2"

  defaultConfig {
    minSdkVersion 10
    targetSdkVersion 15
    versionCode $OPENCV_VER_CODE
    versionName "$OPENCV_VER"
  }

  sourceSets {
    main {
      manifest.srcFile 'AndroidManifest.xml'
      java.srcDirs = ['src']
      resources.srcDirs = ['src']
      res.srcDirs = ['res']
      aidl.srcDirs = ['src']
    }
  }
}

EOF

cd ..
echo "include \"$OPENCV_DIR_NAME\"">> settings.gradle

cd ${ANPL_DIR}/$PROJECT_DIR/
catkin_make
