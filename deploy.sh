platforms="android-arm,android-arm64"
# apk_file="build/app/outputs/bundle/release/app.aab"
apk_file="build/app/outputs/apk/release/app-arm64-v8a-release.apk"
flutter build appbundle --target-platform ${platforms}
flutter build apk --target-platform ${platforms} --split-per-abi
adb push ${apk_file} /sdcard/Download/dungeon-paper.apk
