new-window -n "work_history"
split-window -h
select-pane -t 0
send-keys "vim /home/kudryav_a/work/work_history/work_history" Enter
select-pane -t 1

new-window -n "lcg.trunk"
split-window -v
split-window -v
split-window -v
select-layout even-vertical
select-pane -t 0
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.trunk.e3m-7" Enter
select-pane -t 1
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.trunk.e3m-11" Enter
select-pane -t 2
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.trunk.monoblock-20" Enter
select-pane -t 3
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter

new-window -n "lcg.branch"
split-window -v
split-window -v
select-layout even-vertical
select-pane -t 0
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.e3m-7" Enter
select-pane -t 1
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.e3m-11" Enter
select-pane -t 2
send-keys "ssh rc-082" Enter
send-keys "lcg" Enter
send-keys "./repo/bash/periodical/lcg.sh -f lcg.monoblock-20" Enter

new-window -n "e2ktlogs"
split-window -v
select-pane -t 0
send-keys "cd /home/kudryav_a/work/study/perl-cgi-forms/cgi-bin/" Enter
select-pane -t 1
send-keys "ssh main" Enter
send-keys "mysql -u admelbrus -p" Enter
