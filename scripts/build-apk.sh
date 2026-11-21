#!/usr/bin/env bash
# Build an installable Android debug APK from index.html using Capacitor.
# Usage: npm run apk:build   (run npm run apk:setup once if the SDK platform is missing)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

for tool in node npm npx java python3; do
  command -v "$tool" > /dev/null 2>&1 || { echo "Missing required tool: $tool" >&2; exit 1; }
done

SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"
if [[ -z "$SDK" ]]; then
  SDK=/opt/android-sdk
  [[ -w "$SDK" ]] || SDK="$HOME/Android/Sdk"
fi
export ANDROID_HOME="$SDK"
export ANDROID_SDK_ROOT="$SDK"

if [[ ! -d "$SDK/platforms/android-35" && ! -d "$SDK/platforms/android-34" ]]; then
  echo "Android platform not found in $SDK. Run: npm run apk:setup" >&2
  exit 1
fi

# Capacitor serves a plain web folder, so stage the single-page app there.
rm -rf www
mkdir -p www dist
cp index.html www/index.html

if [[ ! -d node_modules ]]; then
  npm install --no-audit --no-fund
fi

if [[ ! -d android ]]; then
  npx cap add android
fi

# The app uses getUserMedia for hand tracking, so the native app needs the camera permission.
python3 - <<'PY'
from pathlib import Path
p = Path('android/app/src/main/AndroidManifest.xml')
s = p.read_text()
if 'android.permission.CAMERA' not in s:
    s = s.replace('<application', '<uses-permission android:name="android.permission.CAMERA" />\n    <application', 1)
    p.write_text(s)
PY

npx cap sync android

(cd android && ./gradlew assembleDebug)

cp android/app/build/outputs/apk/debug/app-debug.apk dist/string-mirror-debug.apk
echo ""
echo "APK built: $ROOT/dist/string-mirror-debug.apk"
echo "Install on a connected device: adb install -r $ROOT/dist/string-mirror-debug.apk"
