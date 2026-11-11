if [ "$(dpkg --print-architecture)" != "amd64" ]; then
	echo "Unsupported architecture: $(dpkg --print-architecture)" >&2
	exit 1
fi

sudo apt install python-is-python3
if [ $? -ne 0 ]; then
	echo "failed to install python-is-python3" >&2
	exit 1
fi
