#!/bin/bash
set -euo pipefail

if [[ ! -x "$(command -v xdpyinfo)" ]]; then
  echo 'xdpyinfo missing'
fi

RES="$(xdpyinfo | awk '/dimensions:/ { print $2 }')"
RESX="$(echo $RES | awk -Fx '{ print $1 }')"
RESY="$(echo $RES | awk -Fx '{ print $2 }')"

HALFRESX="$(($RESX / 2))"
OFFSETMEMLIST="400"

TREECENTER="-$HALFRESX:0"
CPULISTCENTER="$(($HALFRESX - $RESY)):0"
MEMLISTCENTER="$(($HALFRESX - $RESY + $OFFSETMEMLIST)):0"

if [[ -x "$(command -v docker)" && -x "$(command -v gsettings)" ]]; then
  docker run --rm -v "/tmp:/tmp" -w "/tmp" -v "/proc:/host/proc" pscircle \
    --output=output.png \
    --output-width="$RESX" \
    --output-height="$RESY" \
    --root-pid=1 \
    --collapse-threads=true \
    --max-children=35 \
    --tree-sector-angle=3.1415 \
    --tree-rotate=true \
    --tree-rotation-angle=1.55 \
    --tree-center="$TREECENTER" \
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
    --tree-font-color=a8a8a8 \
    && gsettings set org.gnome.desktop.background picture-uri file:///tmp/output.png
else
  echo 'docker or gsettings missing'
fi
