target=/etc/systemd/user/cros-garcon.service.d/cros-garcon-override.conf
cp $target ${target}.backup
cat $1/setup/fcitx.conf >> $target
