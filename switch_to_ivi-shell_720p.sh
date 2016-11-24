#!/bin/sh
cd /etc/xdg/weston
mv weston.ini weston.ini.desktop-shell
cp /usr/AGL/CES2017/weston.ini.ivi-shell.720p .
ln -sf weston.ini.ivi-shell.720p weston.ini
systemctl restart weston.service
