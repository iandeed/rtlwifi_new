# Completes a complete build and reload of the rtl8723be driver
# Disables sleep mode to resolve intermittent connection failure issues
if [ "$(id -u)" != "0" ]; then
	echo "You must be root to update wireless driver."
	exit 1
fi

echo "Cleaning previous driver installation."
make clean

echo "Compiling driver files."
make

echo "Installing drivers."
make install

echo "Unloading modules"
modprobe -r rtl8723be

echo "Loading new module"
modprobe rtl8723be

echo "Disabling driver sleep feature"
echo 'options rtl8723be fwlps=0'| tee /etc/modprobe.d/rtl8723be.conf
