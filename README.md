# windows-shutdown-timer
Keep your Windows machine awake until elapsed time, then shut it down.

Useful for when you are doing something like downloading large files or installing a program.

This builds upon the functionality of [Insomnia](https://dlaa.me/Insomnia/), which can keep your machine awake as long as its window is open.

[![Build Status](https://travis-ci.org/Jawnnypoo/windows-shutdown-timer.svg?branch=master)](https://travis-ci.org/Jawnnypoo/windows-shutdown-timer)
[![Gem](https://img.shields.io/gem/v/windows-shutdown-timer.svg)](https://rubygems.org/gems/windows-shutdown-timer)

## Setup
Install the gem:
```
gem install windows-shutdown-timer
```

## Usage
After install, run
```
windows-shutdown-timer
```
from cmd. Follow the prompts. You can also run:
```
windows-shutdown-timer 120
```
which would shut down your machine after 120 minutes of keeping it awake.

To cancel a pending shutdown:
```
windows-shutdown-timer -c
```
And if you just want to run Insomnia
```
windows-shutdown-timer -1
```

## Dev Notes
You can ignore these, if you are not developing this gem

### Testing Locally
```
ruby /test/test.rb
```

### Deployment
1. Adjust the version in the gemspec
2. `gem build windows-shutdown-timer.gemspec`
3. `gem push windows-shutdown-timer-version.number.here.gem`
4. Tag release in git

## License

windows-shutdown-timer is available under the MIT license. See the LICENSE file for more info.
