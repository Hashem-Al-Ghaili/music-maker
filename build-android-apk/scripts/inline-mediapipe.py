#!/usr/bin/env python3
"""Embed the MediaPipe tracker assets into the root index.html as gzip+base64 text blocks.

Run after changing the pinned MediaPipe version:
    python3 build-android-apk/scripts/inline-mediapipe.py

Local vendor/mediapipe files are used when present; otherwise the pinned CDN URLs
are downloaded. The script is idempotent: it only rewrites the marked blocks.
"""
from pathlib import Path
import base64
import gzip
import re
import urllib.request

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
INDEX = ROOT / 'index.html'
VENDOR = ROOT / 'vendor' / 'mediapipe'

CDN = 'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.14'
MODEL = ('https://storage.googleapis.com/mediapipe-models/hand_landmarker/'
         'hand_landmarker/float16/1/hand_landmarker.task')

ASSETS = {
    'mp-bundle':     (VENDOR / 'vision_bundle.mjs',              CDN + '/vision_bundle.mjs'),
    'mp-model':      (VENDOR / 'hand_landmarker.task',           MODEL),
    'mp-wasm-js':    (VENDOR / 'wasm/vision_wasm_internal.js',   CDN + '/wasm/vision_wasm_internal.js'),
    'mp-wasm-bin':   (VENDOR / 'wasm/vision_wasm_internal.wasm', CDN + '/wasm/vision_wasm_internal.wasm'),
    'mp-nosimd-js':  (VENDOR / 'wasm/vision_wasm_nosimd_internal.js',  CDN + '/wasm/vision_wasm_nosimd_internal.js'),
    'mp-nosimd-bin': (VENDOR / 'wasm/vision_wasm_nosimd_internal.wasm', CDN + '/wasm/vision_wasm_nosimd_internal.wasm'),
}


def asset_bytes(local, url):
    if local.is_file():
        return local.read_bytes()
    print(f'downloading {url}')
    with urllib.request.urlopen(url, timeout=120) as response:
        return response.read()


def main():
    html = INDEX.read_text()
    total = 0
    for asset_id, (local, url) in ASSETS.items():
        data = asset_bytes(local, url)
        payload = base64.b64encode(gzip.compress(data, 9)).decode('ascii')
        total += len(payload)
        pattern = re.compile(
            r'(<script type="text/plain" id="' + re.escape(asset_id) + r'"[^>]*>).*?(</script>)',
            re.DOTALL,
        )
        html, count = pattern.subn(lambda m: m.group(1) + payload + m.group(2), html, count=1)
        if count != 1:
            raise SystemExit(f'marker for {asset_id} not found in {INDEX}')
        print(f'{asset_id}: {len(data)} bytes -> {len(payload)} base64 chars')
    INDEX.write_text(html)
    print(f'index.html: {INDEX.stat().st_size} bytes ({total} base64 chars embedded)')


if __name__ == '__main__':
    main()
