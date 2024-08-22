<h2 align="center">!!! XeroLinux Changelog !!!!</h2>

I have been following up on all issues reported on Discord. If you notice any, please I urge you to let me know, otherwise I won't be able to fix them. It's up to you. I can't fix what I do not see. Distro will only evolve thanks to all of you. Thanks.

<h3 align="center">September 2024</h3>

This month's version includes a few major changes and minor fixes. See list below.

#### Major Fixes

- ISO uses SystemD-Boot now.
- Bios/MBR Boot mode fixed now.
- Fixed some services not starting.

#### Minor tweaks

- Updated XeroLinux Toolkit.
- Kernel updated to v6.10.6.
- KDE Plasma updated to 6.14.
- Updated Calamares to latest.
- Minor Wayland fixes included.

Even though ISO boots using **SystemD-Boot** it will still be using **Grub** for installed system. Change had to be done to fix issue with Bios boot. Also that's what **Arch** uses by default now. Oh and we highly recommend the use of [**Ventoy**](https://xerolinux.xyz/posts/ventoy-multi-boot/) to boot, so you have **Grub** as fallback in case **SystemD_Boot** fails. If you burn using **Etcher** or similar tools there will be nothing to fall back to. Just an FYI.