#!/usr/bin/env bash
# Install the Android SDK pieces Capacitor needs to build the APK.
set -euo pipefail

SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"
if [[ -z "$SDK" ]]; then
  SDK=/opt/android-sdk
  [[ -w "$SDK" ]] || SDK="$HOME/Android/Sdk"
fi
mkdir -p "$SDK"
export ANDROID_HOME="$SDK"
export ANDROID_SDK_ROOT="$SDK"
echo "Android SDK: $SDK"

sdkmanager_bin="$(command -v sdkmanager || true)"
if [[ -z "$sdkmanager_bin" && -x "$SDK/cmdline-tools/latest/bin/sdkmanager" ]]; then
  sdkmanager_bin="$SDK/cmdline-tools/latest/bin/sdkmanager"
fi
if [[ -z "$sdkmanager_bin" ]]; then
  echo "sdkmanager not found. Install the Android SDK command-line tools first." >&2
  exit 1
fi

# Accept licenses non-interactively, then install the platforms Capacitor templates use.
yes | "$sdkmanager_bin" --licenses --sdk_root "$SDK" > /dev/null 2>&1 || true
"$sdkmanager_bin" --sdk_root "$SDK" \
  "platforms;android-34" "platforms;android-35" \
  "build-tools;34.0.0" "build-tools;35.0.0"

echo "Android SDK ready. Now run: npm run apk:build"
