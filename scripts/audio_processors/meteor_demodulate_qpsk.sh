#!/bin/bash
#
# Purpose: Demodulate Meteor-M 2 audio file in QPSK format.
#
# Input parameters:
#   1. Input QPSK file
#   2. Output .wav file
#
# Example:
#   ./demodulate_meteor_qpsk.sh /path/to/input.qpsk /path/to/output.wav

# import common lib and settings
export PATH=$PATH:/usr/local/bin # added as meteor_demod may be there
. "$HOME/.noaa-v2.conf"
. "$NOAA_HOME/scripts/common.sh"

# input params
INPUT_QPSK=$1
OUTPUT_WAV=$2

# produce the output image
$METEOR_DEMOD -B -o "${INPUT_QPSK}" "${OUTPUT_WAV}" >> $NOAA_LOG 2>&1
