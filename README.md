# docker-pscircle
> systemd + gnome required

1. `docker build -t pscircle .`
2. `cp ./wallpaper-update.* ~/.config/systemd/user/`
3. `systemctl --user enable --now wallpaper-update.timer`
