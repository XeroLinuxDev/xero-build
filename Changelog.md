<h1 align="center">Flagship KDE Edition</h1>

<h3 align="center">March 2025</h3>

This month's version includes a few changes and some minor fixes. See list below.

#### Chages/Fixes

- Kernel 6.13.5.
- KDE Plasma 6.3.2.
- Xero-Toolkit updated.
- Stability improvements.
- Frameworks Updated to 6.11.
- Added Amarok-Qt6 Music Player.
- Updated Layan theme to latest.
- Fixed some Plasmoids not updating.
- Removed Deprecated XWaylandVideoBridge.

Please do not report them here or on Discord. That's it for this month. Just make sure to update the system post-install before doing anything else for best experience.

<h1 align="center">Gnome Dev "Spin"</h1>

<h3 align="center">March 2025</h3>

#### Chages/Fixes

- Kernel 6.13.5.
- Latest Gnome updates.
- Xero-Toolkit updated.
- Stability improvements.
- Added Guake Drop-Down Terminal (F12).

That's it for this month. Just make sure to update the system post-install before doing anything else for best experience. Next release (June) will be doing away with **Ghostty** replacing it with **Ptyxis** which is more developer friendly.

Also ignore fact that **Fasfetch** in **Guake** doesn't show logo, it simply does not support images. If you know of a fix please do let me know, would be appreciated. 

### issues

Currently there is an issue which is breaking upgrade to **Gnome 48**. To fix it, if it happens to you, do the following exactly as listed. Remove gnome-shell-performance package like so :

```Bash
sudo pacman -Rdd gnome-shell-performance
```
Once removed update should go smoothly again. It has been addressed for upcoming ISO in June. Please do not report it here.

<h3 align="center">---------------------------------------------------------------------------</h3>

#### Get support

If you encounter any issues, or have any ideas, and have chosen to donate for ISO + support, please do let me know on **Discord** and I will do my best to fix things. No promises I will add everything, anyway let's discuss. Next ISOs will drop in **June** ;)
