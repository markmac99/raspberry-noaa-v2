#!/bin/bash
#
# Purpose: Send image and message to Mastodon.
#
# Input parameters:
#   1. Annotation
#   2+. List of image paths to send (can be 1-many)
#
# Example:
#   ./scripts/push_processors/push_mastodon.sh "test annotation" "/srv/images/NOAA-18-20210212-091356-MCIR.jpg" \
#                                                               "/srv/images/NOAA-18-20210212-091356-HVC.jpg" \
#                                                               "/srv/images/NOAA-18-20210212-091356-MCIR-precip.jpg"
# import common lib and settings
. "$HOME/.noaa-v2.conf"
. "$NOAA_HOME/scripts/common.sh"
. "$HOME/.tweepy.conf"

# input params
MESSAGE=$1
shift
IMAGES=$@

# check if any images can't be found/accessed
send_images=""
for image in $IMAGES; do
  if [ ! -f "${image}" ]; then
    log "Could not find image ${image} to post - ignoring" "WARN"
  else
    send_images="${send_images} ${image}"
  fi
done

# check if any images are left to send after removing missing ones
if [ -z "${send_images}" ]; then
  log "No images to send - failing" "ERROR"
  exit 1
else
  log "Posting images :" "INFO"
  log "  ${send_images}" "INFO"
  post_resp=$(python3 "${PUSH_PROC_DIR}/post_to_mastodon.py" "${MESSAGE}" ${send_images} 2>&1)
  log "${post_resp}" "INFO"
fi
