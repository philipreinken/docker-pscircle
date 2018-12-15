#!/bin/bash
set -euo pipefail

if [[ ! -x "$(command -v xdpyinfo)" ]]; then
  echo 'xdpyinfo missing'
fi

RES="$(xdpyinfo | awk '/dimensions:/ { print $2 }')"
RESX="$(echo $RES | awk -Fx '{ print $1 }')"
RESY="$(echo $RES | awk -Fx '{ print $2 }')"
RATIO="$(($RESX / $RESY))"

HALFRESX="$(($RESX / 2))"
OFFSETMEMLIST="400"

TREECENTER="-$HALFRESX:0"
CPULISTCENTER="$(($HALFRESX - $RESY)):0"
MEMLISTCENTER="$(($HALFRESX - $RESY + $OFFSETMEMLIST)):0"
WIDESCREEN="$(($RATIO > 2))"

IMGDIR="/tmp/pscircle"
IMGNAME="out.png"

if [[ ! -x "$(command -v docker)" || ! -x "$(command -v gsettings)" ]]; then
  echo 'docker or gsettings missing'
fi

if [[ ! -d "$IMGDIR" ]]; then
  mkdir -p "$IMGDIR"
fi

docker run --rm -u "$(id -u):$(id -g)" -v "$IMGDIR:$IMGDIR:rw" -w "$IMGDIR" -v "/proc:/host/proc:ro" pscircle \
  --output="$IMGNAME" \
  --output-width="$RESX" \
  --output-height="$RESY" \
  --root-pid=1 \
  --collapse-threads=true \
  --max-children=35 \
  --tree-sector-angle=3.1415 \
  --tree-rotate=true \
  --tree-rotation-angle=1.55 \
  --tree-center="$TREECENTER" \
  --cpulist-show="$WIDESCREEN" \
  --memlist-show="$WIDESCREEN" \
  --cpulist-center="$CPULISTCENTER"\
  --memlist-center="$MEMLISTCENTER" \
  --tree-font-size=12 \
  --toplists-font-size=14 \
  --dot-radius=2 \
  --dot-border-width=1 \
  --link-width=1.5 \
  --background-color=2b2929 \
  --link-color-min=267294 \
  --link-color-max=19b6ee \
  --dot-color-min=e95420 \
  --dot-color-max=e95420 \
  --tree-font-color=a8a8a8

gsettings set org.gnome.desktop.background picture-uri "file://$IMGDIR/$IMGNAME"
