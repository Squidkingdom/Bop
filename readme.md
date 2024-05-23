# Bop

This is a Jailbreak tweak that I wrote in highscool to learn apple frameworks and jailbreak tweak devlopment.

This tweak started as a direct fork [Kurt's Lifeguard](https://github.com/Kurrt/Lifeguard) jailbreak tweak which I used as a starting point with the goal being to add the ability to skip, repeat, or pause a song to the side audio buttons.

Default Sequences:
* Pause/Play: Both volume buttons
* Skip Track: Both volume buttons followed by volume up and then volume down
* Previous Track: Both volume buttons followed by volume down and then up

The idea behind these defaults is that my phone is in the pocket of a sweatshirt.

Supports iOS 10.o - 13.5
Dependencies: Cephei, Substrate
To use this tweak, download and install the dep in [releases](https://github.com/Squidkingdom/Bop/releases/), through an iOS package manager such as Cydia, or Zebra.

You can then configure the button sequence for each action in the settings app by typing a string of characters
```
H - Home Button
L - Lock Button
U - Volume Up Button
D - Volume Down Button
S - Mute Switch
P - Screenshot buttons
V - Both Vol. Buttons

So the default sequence for skip track would be 'VUD'
```
