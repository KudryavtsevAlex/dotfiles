new-window -n "dropbox"
send-keys "~/.dropbox-dist/dropboxd" Enter

new-window -n "yandex-browser"
split-window -v
select-pane -t 0
send-keys "~/rootfs/opt/yandex/browser-beta/yandex-browser-beta --no-sandbox" Enter

new-window -n "Telegram"
send-keys "~/rootfs/usr/bin/Telegram/Telegram" Enter

new-window -n "google-chrome"
send-keys "~/rootfs/opt/google/chrome/google-chrome --no-sandbox" Enter

new-window -n "icedove"
send-keys "/usr/bin/icedove" Enter

new-window -n "empathy"
send-keys "/usr/bin/empathy" Enter

new-window -n "learning-on-navarro"
split-window -v
select-pane -t 0
send-keys "ssh kudryav_a@navarro" Enter
