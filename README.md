# docker-pscircle
> dependencies: docker, systemd, gsettings (gnome) and xdpyinfo

1. `docker build -t pscircle .`
2. `cp ./wallpaper-update.* ~/.config/systemd/user/`
3. `systemctl --user enable --now wallpaper-update.timer`

I wanted to avoid installing another list of build tools and dependencies for
[pscircle](https://gitlab.com/mildlyparallel/pscircle/ "pscircle") on my
machine, so I built it in a container and later wondered "why not run it there
as well?". This repo contains the Dockerfile and the pile of hacks that
followed:

 - A systemd timer and unit for triggering the wallpaper generation process
 - A script which
   - gathers information about the connected displays
   - runs pscircle with a fitting configuration (multi-monitor setup or not)
   - sets the image output by pscircle as the new wallpaper via gsettings

