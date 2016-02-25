# Audio Waveform Image Generator

This repository only contains the homebrew formula to easily install `audiowaveform` via homebrew. For other operating systems and code [see the original repository](https://github.com/bbcrd/homebrew-audiowaveform).

[![Build Status](https://travis-ci.org/bbcrd/homebrew-audiowaveform.png?branch=master)](https://travis-ci.org/bbcrd/audiowaveform)

**audiowaveform** is a C++ command-line application that generates waveform data
from either MP3, WAV, or FLAC format audio files. Waveform data can be used to
produce a visual rendering of the audio, similar in appearance to audio editing
applications.

Waveform data files are saved in either binary format (.dat) or JSON (.json).
Given an input waveform data file, **audiowaveform** can also render the audio
waveform as a PNG image at a given time offset and zoom level.

The waveform data is produced from an input stereo audio signal by first
combining the left and right channels to produce a mono signal. The next stage
is to compute the minimum and maximum sample values over groups of *N* input
samples (where *N* is controlled by the `--zoom` command-line option), such that
each *N* input samples produces one pair of minimum and maxmimum points in the
output.

## Install on Mac via Homebrew

    $ brew tap bbcrd/audiowaveform
    $ brew install audiowaveform

### Run

    $ audiowaveform --help

## Command line options

**audiowaveform** accepts the following command-line options:

| Short           | Long                           | Description                                                                                                   |
| --------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------- |
|                 | `--help`                       | Show help message                                                                                             |
| `-v`            | `--version`                    | Show version information                                                                                      |
| `-i <filename>` | `--input-filename <filename>`  | Input mono or stereo audio (.wav or .mp3) or waveform data (.dat) file name                                   |
| `-o <filename>` | `--output-filename <filename>` | Output waveform data (.dat or .json), audio (.wav), or PNG image (.png) file name                             |
| `-z <level>`    | `--zoom <zoom>`                | Zoom level (samples per pixel), default: 256. Not valid if `--end` or `--pixels-per-second` is also specified |
|                 | `--pixels-per-second <zoom>`   | Zoom level (pixels per second), default: 100. Not valid if `--end` or `--zoom` is also specified              |
| `-b <bits>`     | `--bits <bits>`                | Number of bits resolution when creating a waveform data file (either 8 or 16), default: 16                    |
| `-s <seconds>`  | `--start <seconds>`            | Start time (seconds), default: 0                                                                              |
| `-e <seconds>`  | `--end <seconds>`              | End time (seconds). Not valid if `--zoom` is also specified                                                   |
| `-w <width>`    | `--width <width>`              | Width of output image (pixels), default: 800                                                                  |
| `-h <height>`   | `--height <height>`            | Height of output image (pixels), default: 250                                                                 |
| `-c <scheme>`   | `--colors <scheme>`            | Color scheme of output image (either 'audition' or 'audacity'), default: audacity                             |
|                 | `--border-color <color>`       | Border color (in rrggbb\[aa\] hex format), default: set by `--colors` option                                  |
|                 | `--background-color <color>`   | Background color (in rrggbb\[aa\] hex format), default: set by `--colors` option                              |
|                 | `--waveform-color <color>`     | Waveform color (in rrggbb\[aa\] hex format), default: set by `--colors` option                                |
|                 | `--axis-label-color <color>`   | Axis label color (in rrggbb\[aa\] hex format), default: set by `--colors` option                              |
|                 | `--no-axis-labels`             | Render PNG images without axis labels                                                                         |
|                 | `--with-axis-labels`           | Render PNG images with axis labels (default)                                                                  |

### Usage

In general, you should use **audiowaveform** to create waveform data files
(.dat) from input MP3 or WAV audio files, then create waveform images from the
waveform data files.

For example, to create a waveform data file from an MP3 file, at 256 samples
per point with 8-bit resolution:

    $ audiowaveform -i test.mp3 -o test.dat -z 256 -b 8

Then, to create a PNG image of a waveform, either specify the zoom level, in
samples per pixel, or the time region to render.

The following command creates a 1000x200 pixel PNG image from a waveform data
file, at 50 pixels per second, starting at 5.0 seconds from the start of the
audio:

    $ audiowaveform -i test.dat -o test.png --pixels-per-second 50 -s 5.0 -w 1000 -h 200

This command creates a 1000x200 pixel PNG image from a waveform data file,
showing the region from 45.0 seconds to 60.0 seconds from the start of the
audio:

    $ audiowaveform -i test.dat -o test.png -s 45.0 -e 60.0 -w 1000 -h 200

Note that it is not possible to set a zoom level less than that used to create
the original waveform data file.

It is also possible to create PNG images directly from either MP3 or WAV
files, although if you want to render multiple images from the same audio
file, it's generally preferable to first create a waveform data (.dat) file,
and create the images from that, as decoding long MP3 files can take
significant time.

The following command creates a 1000x200 PNG image directly from a WAV file,
at 300 samples per pixel, starting at 60.0 seconds from the start of the
audio:

    $ audiowaveform -i test.wav -o test.png -z 300 -s 60.0 -w 1000 -h 200

The following command converts a waveform data file (.dat) to JSON format:

    $ audiowaveform -i test.dat -o test.json

In addition, **audiowaveform** can also be used to convert MP3 to WAV format
audio:

    $ audiowaveform -i test.mp3 -o test.wav
