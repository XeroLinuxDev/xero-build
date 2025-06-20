<h3 align="center">Flagship KDE Edition</h3>

This month's version includes a lot of changes and some minor fixes. See list below.

#### Chages/Fixes

- Updated to KDE 6.4.
- Moved Wine to Steam (Toolkit).
- Set Falkon as the default Browser.
- Fixed some drive permission issues.
- Switched to Wayland for Live/Auto-Login.

**X11 Notice :** If you are already on **XeroKDE** and require **X11**, manual intervention required. Please install the following packages otherwise you will no longer be able to login to **X11 Session**. That is a major shift by the **Plasma Team**, they split X11 & wayland packages.

```Bash
sudo pacman -Syy kwin-x11 plasma-x11-session
```

#### Additions (Disabled by default)

- Krohnkite tiling. [**Info**](https://github.com/anametologin/krohnkite)
- Smart Video Wallpaper. [**Info**](https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn)
- Plasma Panel Colorizer. [**Info**](https://github.com/luisbocanegra/plasma-panel-colorizer)

Rice : Make sure, if the **XeroLinux** rice gets messed up after update, to run the toolkit from the dock, go to option 7, "**System Troubleshooting & Tweaks**" then option s, "**Reset KDE/Xero Layout back to Stock**" finally select "**yes**" as seen in the image below, to fix it before you start modifying things.

<p align="center">
    <img width="600" src="https://i.imgur.com/LApHOJe.png" alt="fix">
</p>

<h3 align="center">Gnome Dev "Spin"</h3>

#### Chages/Fixes

- Updated to Gnome 48.2.
- Replaced Ghostty with Ptyxis.
- Replaced Deja-Dup with Pika-Backup.
- Added `open-in-ptyxis` for Nautilus.
- Set Epiphany as the default Browser.
- Removed as many QT deps. as possible.
- Replaced Gnome-Extensions with Estension-Manager.

That's it for this month. Just make sure to update the system post-install before doing anything else for best experience.

### issues

None so far, hopefully...

<h3 align="center">---------------------------------------------------------------------------</h3>

#### Get support

If you encounter any issues, or have any ideas, please do let me know on **Discord** and I will do my best to fix things. No promises I will add everything, anyway let's discuss.  Just make sure to update the system post-install before doing anything else for best experience. Next ISOs will drop in **June** ;)
