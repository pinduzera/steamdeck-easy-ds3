# steamdeck-easy-ds3

It is a small to install the required software to pair DS3 on the Steamdeck.

## Usage

Go into desktop mode, clone or copy this repo script and run it in Konsole/terminal

```bash
chmod +x ./installDS3.sh
sudo ./installDS3.sh
```

1. The script check if the required libraries are missing and install if necessary.

2. Then it looks for all the Playstation 3 controllers in the `bluetoothctl` trusted devices and remove all of them. This is necessary because if your controllers battery dies, you will have problem pairing them back in bluetooth unless you removed the previous pairing in the system. ¯\\\_(ツ)_/¯

    * If you ever have problem with your DS3 not wanting to pair the blueetooth, just rerun your script and pair again.

3. Now plug your ds3 through cable, a popup should appear, click in Trust and pair. Now you can remove the cable and your controller will be paired.

Obs.: You might need to rerun this script when the steamdeck updates since it may remove system changes (yay, immutable).

## License

BSD