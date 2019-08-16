#!/usr/bin/env bash
push=0
while test $# -gt 0; do
  case "$1" in
    -p|--push) push=1; shift;;
  esac
done

sep=' '
if [[ $push ]]; then sep=" & Pushing "; fi
echo "Building${sep}APK"

platforms="android-arm,android-arm64"
# apk_file="build/app/outputs/bundle/release/app.aab"
apk_file="build/app/outputs/apk/release/app-arm64-v8a-release.apk"
flutter build appbundle --target-platform ${platforms}
flutter build apk --target-platform ${platforms} --split-per-abi
if [[ $push ]]; then
  adb push ${apk_file} /sdcard/Download/dungeon-paper.apk
fi
