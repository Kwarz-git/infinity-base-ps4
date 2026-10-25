# Infinity Base for PS4 (GoldHEN plugin)

A GoldHEN plugin that makes a jailbroken PS4 think a real **Disney Infinity base** is plugged in — no Raspberry Pi, no hardware. Pick figures from your phone's browser; changes apply live, even in-game.

Tested with **Disney Infinity 3.0 (CUSA01705)** on firmware **11.52**. 2-player supported.

## Features
- Virtual USB base (VID 0E6F / PID 0129) with the full Infinity protocol (auth, slot listing, UID, block read/write)
- Web UI at `http://<ps4-ip>:8080`: Player 1 / Player 2, 4 power-disc slots, 3 hexagon slots
- Figure progress saved automatically; selection restored on next launch
- Removing a figure sends the game the same "figure removed" notice a real base would

## Install
1. Copy `infinity_base_en.prx` to `/data/GoldHEN/plugins/`
2. In `/data/GoldHEN/plugins.ini`:
   ```
   [CUSA01705]
   /data/GoldHEN/plugins/infinity_base_en.prx
   ```
3. Launch the game, open `http://<ps4-ip>:8080` on a phone on the same network.

Data lives in `/data/GoldHEN/infinity/` (`state.txt`, `saves/f<id>.bin`). Copy this folder to keep progress.
Infinity 1.0 / 2.0 may work by adding their CUSA IDs to `plugins.ini` (untested).

## Build
Requires the [OpenOrbis PS4 toolchain](https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain) and the [GoldHEN Plugins SDK](https://github.com/GoldHEN/GoldHEN_Plugins_SDK).

```sh
export OO_PS4_TOOLCHAIN=/path/to/PS4Toolchain
python3 source/gen.py /path/to/your/figure/bins   # generates lib.h and web.h
make
```
The Makefile expects `GoldHEN_Plugins_SDK/` as a sibling folder of this repo.

`bins/` must contain `<version>/<Characters|Playsets|PowerDiscs|ToyBoxes>/*.bin` (320-byte figure dumps, version = `1.0`/`2.0`/`3.0`). Figure dumps are **not** included in this repository; the layout matches [InfinityPi](https://github.com/retardedmonkeygaming/infinity-pi).

Note: the plugin's `.bss` must stay small (the PS4 loader maps only the data segment); keep large data `const`.

## Credits
- [InfinityPi](https://github.com/retardedmonkeygaming/infinity-pi) — protocol reference and figure layout
- [RPCS3](https://rpcs3.net/) Infinity base emulator — authentication math
- OpenOrbis toolchain, GoldHEN Plugins SDK

## Disclaimer
Unofficial, for interoperability with software you own. Not affiliated with Disney or Avalanche. Use at your own risk.
