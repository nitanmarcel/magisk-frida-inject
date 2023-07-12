# Magisk frida inject

Magisk module installing frida-inject with optional functionality to auto inject scripts at app startup


## Building

### Requirements

- android-ndk
- wget
- xz-utils

### Build

- Run action or ./build.sh script.

## Installation

### Requirements

- [magisk-frida](https://github.com/ViRb3/magisk-frida) - Optional, but required if you don't want to push and run frida-server from adb every time.

### From GITHUB

- Download latest release: https://github.com/nitanmarcel/magisk-frida-inject/releases

### Usage

- `frida-inject ...` - see `frida-inject --help` for all available options.

- To automatically inject scripts at app startup, place the js file in `/data/misc/user/0/frida-inject/`  as `package.name.js` (replace the package.name with the package name of the target application)


## Credits

- Frida - for frida inject
- HuskyDG - for this module's template
- https://gist.github.com/vvb2060/a3d40084cd9273b65a15f8a351b4eb0e#file-am_proc_start-cpp