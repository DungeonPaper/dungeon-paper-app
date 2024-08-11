#!/usr/bin/env bash

name=$(dart run btool get packageName)
version=$(dart run btool get packageVersion)
basen="$name-$version"
dn="Dungeon Paper"

android_push_to_device() {
  local src
  src="$(pwd)/build/app/outputs/flutter-apk/app-release.apk"
  local target="/sdcard/Download/$basen.apk"
  adb push "$src" "$target"
}

android_install() {
  adb uninstall app.dungeonpaper
  adb install -r build/app/outputs/flutter-apk/app-release.apk
}

android_release() {
  bundleout="$basen.aab"
  bundle="build/app/outputs/bundle/release/app-release.aab"
  mkdir -p release/android
  cp "$bundle" "release/android/$bundleout"
  android_collect_symbols
  [[ ! -f "$(which open)" ]] || open release/android
}

android_collect_symbols() {
  dir="$(pwd)/release/android"
  filename="symbols-$basen.zip"
  mkdir release
  pushd build/app/intermediates/merged_native_libs/release/out/lib || exit
  zip -r "$dir/$filename" ./*/*
  popd || exit
  [[ ! -f "$(which open)" ]] || open release/android
}

ios_release() {
  bundleout="$basen.ipa"
  bundle="build/ios/ipa/$dn.ipa"
  mkdir -p release/ios
  cp "$bundle" "release/ios/$bundleout"
  [[ ! -f "$(which open)" ]] || open release/ios
}

macos_pack() {
  app="build/macos/Build/Products/Release/$dn.app"
  title="$dn"
  outdir="release/macos"
  tmp="$outdir/pack.temp.dmg"
  dmgout="$basen.dmg"
  source="macos/build/dmg"

  rm -rf "$source"
  mkdir -p "$source/.background"
  cp -r "$app" "$source"
  cp "assets/images/dmg_bg.png" "$source/.background/background.png"
  ln -s "/Applications" "$source/Applications"
  size=$(du -sk "$source" | awk '{print $1}')
  size=$((size + (1024 * 10)))

  echo "Creating DMG: $dmgout"
  hdiutil create -srcfolder "$source" -volname "$title" -fs HFS+ \
    -fsargs "-c c=64,a=16,e=16" -format UDRW -size "${size}k" "$tmp"
  echo "Attaching $tmp"
  device=$(hdiutil attach -readwrite -noverify -noautoopen "$tmp" | \
     grep -E '^/dev/' | sed 1q | awk '{print $1}')
  sleep 0.5

  echo "Making layout modifications"
  echo "
    tell application \"Finder\"
      tell disk \"$title\"
        open
        set current view of container window to icon view
        set toolbar visible of container window to false
        set statusbar visible of container window to false
        set the bounds of container window to {400, 200, 900, 500}
        set theViewOptions to the icon view options of container window
        set arrangement of theViewOptions to not arranged
        set icon size of theViewOptions to 112
        set background picture of theViewOptions to file \".background:background.png\"
        # make new alias file at container window to POSIX file \"/Applications\" with properties {name:\"Applications\"}
        set position of item \"$title\" of container window to {112, 112}
        set position of item \"Applications\" of container window to {387, 112}
        close
        open
        update without registering applications
        delay 5
        close
      end tell
    end tell
  " | osascript
  chmod -Rf go-w "/Volumes/$title"
  sync
  sync

  echo "Detaching $tmp"
  hdiutil detach "$device"

  echo "Converting $tmp to $dmgout"
  [[ -f "release/macos/$dmgout" ]] && rm "$outdir/$dmgout"
  hdiutil convert "$tmp" -format UDZO -imagekey zlib-level=9 -o "$outdir/$dmgout"
  rm -f "$tmp"
  webdir="../dungeon-paper-website/public/downloads/macos"
  mkdir -p "$webdir"

  [[ ! -f "$(which open)" ]] || open release/macos
}

run_cond() {
  cond="$1"
  shift
  cmd="$*"
  if [[ $# -lt 1 ]]; then
    if [[ -n $cond ]]; then return 0; else return 1; fi
  fi
  if [[ -n $cond ]]; then
    $cmd
  fi
}

main() {
  if [[ $# -gt 0 ]]; then
    case $1 in
      "android")
        shift
        while [[ $# -gt 0 ]]; do
          case $1 in
            --build) build=1 ;;
            --apk) build=1; apk=1 ;;
            --aap) build=1; aab=1 ;;
            --push) push=1 ;;
            --install) install=1 ;;
            --release) release=1; build=1; aab=1 ;;
            --symbols) symbols=1 ;;
            *) echo "Unknown command or option: android $1. Available flags: --build, --apk, --aap, --push, --install, --release" ;;
          esac
          shift
        done
        if run_cond "$build"; then
          run_cond "$apk" 'flutter build apk'
          run_cond "$aab" 'flutter build appbundle'
        fi
        if run_cond "$release"; then
          android_release
        elif run_cond "$symbols"; then
          android_collect_symbols
        fi
        run_cond "$push" android_push_to_device
        run_cond "$install" android_install
        ;;
      ios)
        shift
        while [[ $# -gt 0 ]]; do
          case $1 in
            --build) build=1 ;;
            --app) build=1; app=1 ;;
            --ipa) build=1; ipa=1 ;;
            --release) release=1; build=1; ipa=1 ;;
            --repo-update) repo_update=1 ;;
            *) echo "Unknown command or option: ios $1. Available flags: --build, --app, --ipa, --release, --repo-update" ;;
          esac
          shift
        done
        if run_cond "$repo_update"; then
          pushd ios || exit
          pod repo update && pod install
          popd || exit
        fi
        if run_cond "$build"; then
          run_cond "$app" 'flutter build app'
          run_cond "$ipa" 'flutter build ipa'
        fi
        # TODO get existing github release or create new one, then upload artifact as asset (replace existing if needed)
        ;;
      macos)
        shift
        while [[ $# -gt 0 ]]; do
          case $1 in
            --build) build=1 ;;
            --pack) release=1; pack=1 ;;
            --repo-update) repo_update=1 ;;
            *) echo "Unknown command or option: ios $1. Available flags: --build, --pack, --repo-update" ;;
          esac
          shift
        done
        if run_cond "$repo_update"; then
          pushd macos || exit
          pod repo update && pod install
          popd || exit
        fi
        run_cond "$build" 'flutter build macos'
        run_cond "$pack" macos_pack
        run_cond "$release" ios_release
        ;;
      web)
        shift
        while [[ $# -gt 0 ]]; do
          case $1 in
            --build) build=1 ;;
            --publish) publish=1 ;;
            --release) build=1; publish=1; ;;
            *) echo "Unknown command or option: ios $1. Available flags: --build, --publish, --release" ;;
          esac
          shift
        done
        run_cond "$build" 'flutter build web'
        run_cond "$publish" 'firebase deploy --only hosting'
        ;;
      *)
        echo "Unknown command: $1"
        ;;
    esac
  else
    echo "Usage: build.sh <android|ios|macos|web> [flags]"
  fi
}

main "$@"