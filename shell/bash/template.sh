EXTRAPORLATED_STRING='my custom string'


cat > /path/to/file <<EOF
SystemCfg:
    - logfile:    /var/tmp/xmalog.log
    - loglevel:   2
    - param: ${EXTRAPORLATED_STRING}
EOF

