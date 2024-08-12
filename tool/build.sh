#!/usr/bin/env bash

ensure_token() {
  if [[ -z $GITHUB_TOKEN ]]; then
    echo "$(tput setaf 1)GITHUB_TOKEN is not set"
    echo "Please set GITHUB_TOKEN environment variable to a valid GitHub token$(tput sgr0)"
    exit 1
  fi
}

echo "Getting package info..."
name=$(dart run btool get packageName)
version=$(dart run btool get packageVersion)
ver=${version/\+[0-9]*/}
basen="$name-$version"
title="Dungeon Paper"
repo="DungeonPaper/dungeon-paper-app"
y=$(tput setaf 3)
c=$(tput setaf 6)
re=$(tput sgr0)
notes_updated=

ask() {
  is_linux=$(uname | grep -i linux)
  q="$1"
  printf "%s%s [Y/n]: %s" "$c" "$q" "$re"
  if [[ -n $is_linux ]]; then
    read -r -n 1 ans
  else
    read -r ans
  fi
  if [[ -z $ans || "$ans" =~ [yY] ]]; then
    return 0
  else
    return 1
  fi
}

ask_no() {
  q="$1"
  printf "%s%s [y/N]: %s" "$c" "$q" "$re"
  if [[ -n $is_linux ]]; then
    read -r -n 1 ans
  else
    read -r ans
  fi
  if [[ "$ans" =~ [yY] ]]; then
    return 0
  else
    return 1
  fi
}

get_release() {
  releases_json=$(curl -s "https://api.github.com/repos/$repo/releases")
  if [[ -z $releases_json ]]; then
    echo "Failed to get releases from $repo"
    exit 1
  fi

  releases_json=$(jq -r ".[] | select(.tag_name == \"v$ver\")" <<< "$releases_json")
  printf "%s\n" "$releases_json"
}

create_or_get_release() {
  echo "Getting releases from $repo"
  releases_json=$(get_release)

  if [[ -z $releases_json ]]; then
    if ask "Release $ver not found, do you want to create it?"; then
      if ask_no "Do you want to create a tag for release $ver?"; then
        echo "Creating tag"
        git tag "v$ver"
        git push --tags
      fi

      if ask "Do you want to create release $ver?"; then
        ensure_token
        echo "Creating release $ver"
        release_notes=$(generate_release_notes)
        release_json=$(curl -s -X POST "https://api.github.com/repos/$repo/releases" \
          -H "Authorization: Bearer $GITHUB_TOKEN" \
          -d "{\"tag_name\":\"v$ver\",\"name\":\"v$ver\",\"body\":\"$release_notes\"}")

        if [[ -z $release_json ]]; then
          echo "Failed to create release $ver"
          exit 1
        fi
      fi
    fi
  else
    echo "Release $ver found"
    update_release_notes
  fi
}

update_release_notes() {
  if [[ -n "$notes_updated" ]]; then
    return
  fi
  notes_updated=1
  if ask "Do you want to update release $ver release notes?"; then
    ensure_token
    echo "Updating release $ver"
    release_notes=$(generate_release_notes | jq -R -s)
    release_id=$(jq -r ".id" <<< "$releases_json")
    release_json=$(curl -s -L -X PATCH "https://api.github.com/repos/$repo/releases/$release_id" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -d "{\"body\":$(printf "%s\n" "$release_notes")}")
    if [[ -z $release_json ]]; then
      echo "Failed to update release $ver"
      exit 1
    fi
    echo "Done"
  fi
}

upload_asset_to_release() {
  asset_location=$(realpath "$1")
  asset_name="$2"
  if [[ -z "$asset_name" ]]; then
    asset_name=$(basename "$asset_location")
  fi
  asset_name=${asset_name/ /%20}
  asset_name=${asset_name/\+/%2B}
  # zip_file="$asset_name.zip"
  # echo "Creating zip file $zip_file"
  # rm -f "$zip_file"
  # zip -r "$zip_file" "$asset_location"
  # asset_location="$zip_file"
  # asset_name="$zip_file"
  echo "Preparing release info before uploading asset $asset_name..."

  create_or_get_release
  release_json=$(get_release)

  upload_url=$(jq -r ".upload_url" <<< "$releases_json")
  upload_url=${upload_url/\{?name,label\}//}
  upload_url=${upload_url%/}

  asset_exists=$(jq -r ".assets | .[] | select(.name == \"$asset_name\")" <<< "$releases_json")

  if [[ -n $asset_exists ]]; then
    echo "Asset $asset_name already exists in release $ver"
    asset_id=$(jq -r ".id" <<< "$releases_json")
    if ask "Delete existing asset $asset_name?"; then
      ensure_token
      echo "Deleting existing asset $asset_name"
      curl -s -X DELETE "https://api.github.com/repos/$repo/releases/assets/$asset_id" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "Content-Type: application/json"
    fi
  fi

  if ask "Do you want to upload asset $asset_name to release $ver?"; then
    echo "Uploading $asset_name to release $ver"
    curl -s -L -X POST "$upload_url?name=$asset_name" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      -H "Content-Type: multipart/form-data" \
      --data-binary "@$asset_location"

    ex="$?"
    if [[ "$ex" -ne 0 ]]; then
      echo "Failed to upload asset $asset_name"
      exit 1
    fi
    echo "Uploaded $asset_name"
  else
    echo "Skipping upload of $asset_name"
  fi
}

generate_release_notes() {
  changelog_file="../dungeon-paper-website/public/CHANGELOG.md"
  cl=$(cat "$changelog_file")
  notes="## What's Changed"
  notes="$notes\n$(awk "/^## $ver/{flag=1;next}/^## /{flag=0}flag" <<< "$cl")"
  prev_ver=$(awk '/^##/{print $2;exit}' <<< "$cl")
  diff_url="https://github.com/DungeonPaper/dungeon-paper-app/compare/v${ver}...v${prev_ver}"
  notes="$notes\n\n**Full Changelog:** $diff_url"
  echo "$notes"
}

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
  bundle="build/ios/ipa/$title.ipa"
  mkdir -p release/ios
  cp "$bundle" "release/ios/$bundleout"
  [[ ! -f "$(which open)" ]] || open release/ios
}

macos_pack() {
  app="build/macos/Build/Products/Release/$title.app"
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

  cmd=$*
  if [[ $# -lt 1 ]]; then
    if [[ -n $cond ]]; then return 0; else return 1; fi
  fi
  if [[ -n $cond ]]; then
    echo "Running: $cmd"
    $cmd
  fi
}

# main
if [[ $# -gt 0 ]]; then
  case $1 in
    "android")
      shift
      while [[ $# -gt 0 ]]; do
        case $1 in
          --build) build=1 ;;
          --apk) build=1; apk=1 ;;
          --aab) build=1; aab=1 ;;
          --push) push=1 ;;
          --install) install=1 ;;
          --release) release=1; build=1; aab=1 ;;
          --symbols) symbols=1 ;;
          --gh-release) gh_release=1 ;;
          *) echo "Unknown command or option: android $1. Available flags: --build, --apk, --aap, --push, --install, --release, --gh-release" ;;
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
      run_cond "$gh_release" upload_asset_to_release 'build/app/outputs/flutter-apk/app-release.apk' "$basen.apk"
      run_cond "$gh_release" upload_asset_to_release 'build/app/outputs/bundle/release/app-release.aab' "$basen.aab"
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
          --gh-release) gh_release=1 ;;
          *) echo "Unknown command or option: ios $1. Available flags: --build, --app, --ipa, --release, --repo-update, --gh-release" ;;
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
      run_cond "$gh_release" upload_asset_to_release "build/ios/ipa/$title.ipa" "$basen.ipa"
      ;;
    macos)
      shift
      while [[ $# -gt 0 ]]; do
        case $1 in
          --build) build=1 ;;
          --pack) pack=1 ;;
          --repo-update) repo_update=1 ;;
          --gh-release) gh_release=1 ;;
          *) echo "Unknown command or option: ios $1. Available flags: --build, --pack, --repo-update, --gh-release" ;;
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
      run_cond "$gh_release" upload_asset_to_release "release/macos/$basen.dmg" "$basen.dmg"
      ;;
    web)
      shift
      while [[ $# -gt 0 ]]; do
        case $1 in
          --build) build=1 ;;
          --publish) publish=1 ;;
          --release) build=1; publish=1; ;;
          *) echo "Unknown command or option: ios $1. Available flags: --build, --publish, --release, --gh-release" ;;
        esac
        shift
      done
      run_cond "$build" 'flutter build web'
      run_cond "$publish" 'firebase deploy --only hosting'
      ;;
    release-notes)
      generate_release_notes
      ;;
    *)
      echo "Unknown command: $1"
      ;;
  esac
else
  echo "Usage: build.sh <android|ios|macos|web> [flags]"
fi