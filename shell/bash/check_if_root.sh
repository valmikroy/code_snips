if [ "$EUID" -ne '0' ]; then
        echo "ERROR: $0 requires root privileges!"
        exit 1
fi
