# Music Maker

**This fork implements & optimizes the site for mobile screen usage**
- Optimization for mobile/smartphone screen size and also landscape mode
- Play with touch screen (like with mouse on desktop version), add string functions have been moved to 2-finger-tip / pinching. 
- Optimization for mobile/smartphone screen size and also landscape mode.
- Play with touch screen (like with mouse on desktop version).
- Add/Edit string functions have been moved to 2-finger-tip + hold / pinching+hold) and its info in the play style selection. 
- experimental fretless/TET based tuning.


**Created by: Hasem Al-Ghaili**  
forked & extended by Nemanja Bocokic / ccne4mocc

Stretch strings in the air, give each one an instrument, and play them with your fingers.
A single-page, camera-tracked instrument that runs entirely in the browser.

## How it works

- **Stretch** – pinch thumb to index finger on both hands, pull apart, let go. A string stays where you left it.
- **Choose** – pick one of 24 instruments and a tone (major, minor, pentatonic, blues, dorian, hijaz). Each string can also switch between smooth fretless pitch and stepped 12-TET; fretless strings show root, octave and A4 = 440 Hz reference markers.
- **Play** – sweep a fingertip across a string. Add a beat, loop your own layers, and record the result as video, MP3 or WAV.

No camera? Choose "Play with the mouse instead" on the start screen. On a touch screen, choose **Play with touch** (or the finger icon in the top bar) to turn on **Touch play**.

## Touch play

With Touch play on, one finger sweeps across strings to pluck them, and several fingers can play several strings at the same time. Making and editing strings moves to two fingers:

- **Make a string** – hold two or three fingers still for a moment, then spread them apart and let go. You can also start them apart and pinch them together to make a string between their starting points. A quick two-finger sweep only plays; it never starts a string.
- **Change a string** – hold two close fingers still on a string's badge and tap to open its instrument menu. Move them together to drag an end, bend a string, or work the air pad.
- Holding two fingers still in open air and moving them together works the air pad (dark / thin / echo). Active FX values are shown as translucent badges above nearby strings.

Tapping the finger icon again turns Touch play off and restores one-finger dragging for building and editing. The start screen shows the control summary right under **Play with touch**. Settings has a **Playing fingers** slider from 1 (index only) to 4 (index through pinky).

## Layouts

The landing screen picks a layout from the screen: phones and tablets get **Mobile**, everything else keeps the original **Desktop** layout. Your choice is saved in the browser and can be changed later in **Settings → Switch layout**.

- **Desktop** – full-width control bars, mouse and keyboard shortcuts, 16:9 stage.
- **Mobile portrait** – controls fold into slim top and bottom handles. Tap a handle's chevron to open it; opening one closes the other so the stage stays usable. Touch targets, canvas labels and menus scale up, and the camera picture fills the screen.
- **Mobile landscape** – the two bars become left and right rails that span the full screen height. Tap a rail's chevron to slide it out; its controls fill the remaining height and scroll there, while the stage keeps the middle.
- The bottom bar has two choosable panels: **Beat & record** (beat, layers and **Export stems**) and **Mixer** (a fader per playing source, so no separate mixer window opens). Pinch a fader to set it; pinch the empty space and drag to scroll a long list.

Append `#mobile`, `#desktop` or `#demo` to the URL to open a layout directly. `#demo` forces the desktop layout and runs the scripted hands without a camera. The stage shape follows the layout and rotation (16:9 on desktop and in landscape, 9:16 in mobile portrait); there is no separate rotation button.

## Notes

- Use Chrome or Edge. The camera needs a secure (https) page, which GitHub Pages provides.
- Hand tracking uses MediaPipe Hand Landmarker, loaded from a CDN on first use.
- All sound is synthesised in the browser; there are no audio samples.
- MP3 export uses [lamejs](https://github.com/zhuker/lamejs) (LGPL-3.0), embedded in the page.
