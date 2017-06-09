# windows-shutdown-timer
Keep Windows machine awake until elapsed time, then shutting it down

Useful for when you are doing something like downloading large files or installing a program.

This builds upon the functionality of [Insomnia](https://dlaa.me/Insomnia/) which can keep your machine awake as long as its window is open.

[![Build Status](https://travis-ci.org/Jawnnypoo/windows-shutdown-timer.svg?branch=master)](https://travis-ci.org/Jawnnypoo/windows-shutdown-timer)
[![Gem](https://img.shields.io/gem/v/windows-shutdown-timer.svg)](https://rubygems.org/gems/windows-shutdown-timer)

## Setup
Install the gem:
```
gem install windows-shutdown-timer
```

## Usage
After install Run:
```
windows-shutdown-timer
```
from cmd. Follow the prompts. You can also run:
```
windows-shutdown-timer 120
```
which would shut down your machine after 2 hours of keeping it awake.

To cancel:
```
windows-shutdown-timer -c
```
## License

windows-shutdown-timer is available under the MIT license. See the LICENSE file for more info.
