# docker-pscircle
> dependencies: docker, systemd, gsettings (gnome) and xdpyinfo

1. `docker build -t pscircle .`
2. `cp ./wallpaper-update.* ~/.config/systemd/user/`
3. `systemctl --user enable --now wallpaper-update.timer`
