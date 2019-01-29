Create systemd onshot execution service which should only run once after host gets rebooted and prevent it from running with any subsequent `systemctl restart` commands.

- Oneshot execution systemd unit file `/etc/systemd/system/myoneshot.service`
```
[Unit]
Description=myoneshot
ConditionPathExists=!/tmp/myoneshot.DONE

[Service]
Type=oneshot
User=root
Group=root
RemainAfterExit=true
EnvironmentFile=-/etc/default/myoneshot
EnvironmentFile=-/etc/sysconfig/myoneshot
ExecStart=/opt/myoneshot/bin/myscript.sh
ExecStartPost=/usr/bin/touch /tmp/myoneshot.DONE
WorkingDirectory=/

[Install]
WantedBy=multi-user.target
```

- reload daemon with `sudo systemctl --system daemon-reload`

- add service to startup sequence `sudo systemctl enable myoneshot`

- run it once `sudo systemctl start myoneshot`
