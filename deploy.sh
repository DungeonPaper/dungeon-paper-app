#!/usr/bin/env bash
push=0
install=0
while test $# -gt 0; do
  case "$1" in
    -p|--push) push=1; shift;;
    -i|--install) install=1; shift;;
    *) version=$1; shift;;
  esac
done

sep=' '
if [[ $version ]]; then echo "Version: $version"; fi
if [[ $push ]]; then sep="$sep& Pushing "; fi
if [[ $install ]]; then sep="$sep& Installing "; fi
echo "Building${sep}APK"

platforms="android-arm,android-arm64"
# apk_file="build/app/outputs/bundle/release/app.aab"
apk_file="build/app/outputs/apk/release/app-arm64-v8a-release.apk"
flutter build appbundle --target-platform ${platforms}
flutter build apk --target-platform ${platforms} --split-per-abi
if [[ $push ]]; then
  echo "Pushing ${apk_file} to /sdcard/Download/dungeon-paper-${version}.apk"
  adb push ${apk_file} /sdcard/Download/dungeon-paper-${version}.apk
fi

if [[ $install ]]; then
  echo "Installing ${apk_file}"
  adb install -r ${apk_file}
fi
