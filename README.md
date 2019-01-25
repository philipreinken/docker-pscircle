# docker-pscircle
> dependencies: docker, systemd, gsettings (gnome) and xdpyinfo

1. `docker build -t pscircle .`
2. `cp ./wallpaper-update.* ~/.config/systemd/user/`
3. `systemctl --user enable --now wallpaper-update.timer`

I built [pscircle](https://gitlab.com/mildlyparallel/pscircle/ "pscircle")
in a container just to try it out and to avoid installing another set of build
dependencies on my machine. This repo contains the pile of hacks that followed:

 - A Dockerfile to build the image
 - A systemd timer and unit for triggering the wallpaper generation process
   every minute
 - A script which
   - gathers information about the connected displays
   - runs the pscircle container with a fitting configuration
   - sets the image output by pscircle as the new wallpaper via gsettings

