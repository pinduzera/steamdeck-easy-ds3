#!/bin/bash

# Required packages
REQUIRED_PKGS=("bluez" "bluez-plugins")
MISSING_PKGS=()

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "'$pkg' is not installed."
        MISSING_PKGS+=("$pkg")
    fi
done

if (( ${#MISSING_PKGS[@]} > 0 )); then
    echo "Installing missing packages: ${MISSING_PKGS[*]}"

    sudo steamos-readonly disable
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacman-key --populate holo

    sudo pacman -S --noconfirm "${MISSING_PKGS[@]}"
else
    echo "All required packages are already installed."
fi

# if the controllers were previously paired, you must remove them
devices=$(bluetoothctl devices Trusted)

echo "$devices" | grep -E "PLAYSTATION\(R\)3" | while read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)

    echo "Removing PS3 controller: $name ($mac)"
    bluetoothctl remove "$mac"
done

echo "Connect your DS3 through cable, authorize the pop up, DS3 is now paired."