#!/usr/bin/env bash
push=0
install=0
build=1
version=latest

trap ctrl_c SIGINT

function ctrl_c() {
  exit
}

while test $# -gt 0; do
  case "$1" in
    -p|--push) push=1; shift;;
    -i|--install) install=1; shift;;
    -b|--no-build) build=0; shift;;
    *) version=$1; shift;;
  esac
done

sep=''
echo "Version: $version"
if [ $build -eq 1 ]; then sep="Building "; fi
if [ $push -eq 1 ] && [ $build -eq 1 ]; then sep="$sep& "
if [ $push -eq 1 ]; then sep="${sep}Pushing "; fi
if [ $install -eq 1 ] && [ [ $build -eq 1 ] || [ $push -eq 1]; then sep="$sep& "
if [ $install -eq 1 ]; then sep="${sep}Installing "; fi
echo "${sep}APK"

platforms="android-arm,android-arm64"
# bundle_file="build/app/outputs/bundle/release/app.aab"
apk_file="build/app/outputs/apk/release/app-arm64-v8a-release.apk"

if [ $build -eq 1 ]; then
  flutter build appbundle --target-platform ${platforms}
  flutter build apk --target-platform ${platforms} --split-per-abi
fi

if [ $push -eq 1 ]; then
  echo "Pushing ${apk_file} to /sdcard/Download/dungeon-paper-${version}.apk"
  adb push ${apk_file} /sdcard/Download/dungeon-paper-${version}.apk
fi

if [ $install -eq 1 ]; then
  echo "Installing ${apk_file}"
  adb install -r ${apk_file} || (adb uninstall app.dungeonpaper && adb install -r ${apk_file})
fi

trap - SIGINT
