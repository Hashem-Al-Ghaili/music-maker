# Music Maker

**This fork implements & optimizes the site for mobile screen usage**
- Optimization for mobile/smartphone screen size and also landscape mode
- Play with touch screen (like with mouse on desktop version), add string functions have been moved to 2-finger-tip / pinching. 

**Originial created by: Hashem Al-Ghaili**

Stretch strings in the air, give each one an instrument, and play them with your fingers.
A single-page, camera-tracked instrument that runs entirely in the browser.

**Play it:** https://hashem-al-ghaili.github.io/music-maker/


## How it works

- **Stretch** – pinch thumb to index finger on both hands, pull apart, let go. A string stays where you left it.
- **Choose** – pick one of 24 instruments and a tone (major, minor, pentatonic, blues, dorian, hijaz).
- **Play** – sweep a fingertip across a string. Add a beat, loop your own layers, and record the result as video, MP3 or WAV.

No camera? Choose "Play with the mouse instead" on the start screen. On a touch screen, choose **Play with touch** (or the finger icon in the top bar) to turn on **Touch play**.

## Touch play

With Touch play on, one finger sweeps across strings to pluck them, and several fingers can play several strings at the same time. Making and editing strings moves to two fingers:

- **Make a string** – hold two fingers close together and spread them apart, then let go. You can also start them apart and pinch them together to make a string between their starting points.
- **Change a string** – hold two close fingers still on a string's badge and tap to open its instrument menu. Move them together to drag an end, bend a string, or work the air pad.

Tapping the finger icon again turns Touch play off and restores one-finger dragging for building and editing.

## Layouts

The landing screen picks a layout from the screen: phones and tablets get **Mobile**, everything else keeps the original **Desktop** layout. Your choice is saved in the browser and can be changed later in **Settings → Switch layout**.

- **Desktop** – full-width control bars, mouse and keyboard shortcuts, 16:9 stage.
- **Mobile portrait** – controls fold into slim top and bottom handles. Tap a handle's chevron to open it; opening one closes the other so the stage stays usable. Touch targets, canvas labels and menus scale up, and the camera picture fills the screen.
- **Mobile landscape** – the two bars become left and right rails that span the full screen height. Tap a rail's chevron to slide it out; its controls fill the remaining height and scroll there, while the stage keeps the middle.

Append `#mobile`, `#desktop` or `#demo` to the URL to open a layout directly. `#demo` forces the desktop layout and runs the scripted hands without a camera.

## Notes

- Use Chrome or Edge. The camera needs a secure (https) page, which GitHub Pages provides.
- Hand tracking uses MediaPipe Hand Landmarker, loaded from a CDN on first use.
- All sound is synthesised in the browser; there are no audio samples.
- MP3 export uses [lamejs](https://github.com/zhuker/lamejs) (LGPL-3.0), embedded in the page.
