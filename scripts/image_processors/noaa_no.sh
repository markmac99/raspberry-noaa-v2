#!/bin/bash
#
# Purpose: NOAA colour IR contrast enhancement option. Greatly increases contrast in the darker land/sea 
# 	   regions and colours the cold cloud tops. Allows fine detail in land and sea to be seen and provides 
#	   a very readable indication of cloud top tempera- tures. This enhancement option is temperature normalised.
#
# Input parameters:
#   1. Map overlap file
#   2. Input .wav file
#   3. Output .jpg file
#
# Example:
#   ./noaa_msa.sh /path/to/map_overlay.png /path/to/input.wav /path/to/output.jpg

# import common lib and settings
. "$HOME/.noaa-v2.conf"
. "$NOAA_HOME/scripts/common.sh"

# input params
MAP_OVERLAY=$1
INPUT_WAV=$2
OUTPUT_IMAGE=$3

# calculate any extra args for the processor
extra_args=""
if [ "${NOAA_CROP_TELEMETRY}" == "true" ]; then
  extra_args=${extra_args}" -c"
fi

if [ "${NOAA_CROP_TOPTOBOTTOM}" == "false" ]; then
  extra_args=${extra_args}" -A"
fi

if [ "${NOAA_INTERPOLATE}" == "true" ]; then
  extra_args=${extra_args}" -I"
fi

# produce the output image
$WXTOIMG -o -m "${MAP_OVERLAY}" ${extra_args} -e "NO" "${INPUT_WAV}" "${OUTPUT_IMAGE}"
