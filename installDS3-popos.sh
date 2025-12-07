#!/bin/bash

# Required packages for Bluetooth + PS3 pairing support
REQUIRED_PKGS=("bluez" "bluez-tools")
MISSING_PKGS=()

# Detect missing packages
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! dpkg -s "$pkg" &> /dev/null; then
        echo "'$pkg' is not installed."
        MISSING_PKGS+=("$pkg")
    fi
done

# Install missing packages if needed
if (( ${#MISSING_PKGS[@]} > 0 )); then
    echo "Installing missing packages: ${MISSING_PKGS[*]}"

    sudo apt update
    sudo apt install -y "${MISSING_PKGS[@]}"
else
    echo "All required packages are already installed."
fi

echo

# Remove previously paired PS3 controllers
echo "Checking for previously trusted PS3 controllers..."

devices=$(bluetoothctl devices Trusted)

# DS3 often appears as "PLAYSTATION(R)3 Controller" or "PS3 Controller"
echo "$devices" | grep -Ei "PLAYSTATION\(R\)3" | while read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)

    echo "Removing PS3 controller: $name ($mac)"
    bluetoothctl remove "$mac"
done

echo
echo "Now connect your DualShock 3 (PS3 Controller) via USB cable."
echo "Authorize the Bluetooth pairing popup." 
echo "If a popup Doesn't show it may be due to the DE, go to the terminal and"
echo "'bluetoothctl trust <mac>'"
echo 
echo "To get the Mac addresses of your devices do 'bluetoothctl devices'"

