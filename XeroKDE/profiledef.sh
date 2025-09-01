#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="xerolinux-kde"
iso_label="XERO_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="DarkXero"
iso_application="xerolinux"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m)"
install_dir="arch"
buildmodes=('iso')
## GRUB
#bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.grub.esp' 'uefi-x64.grub.eltorito')
## systemd-boot
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/vcheck"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/dmcheck"]="0:0:755"
  ["/usr/local/bin/xerolinux-before"]="0:0:755"
  ["/usr/local/bin/skel"]="0:0:755"
  ["/usr/local/bin/all-cores"]="0:0:755"
  ["/usr/local/bin/xerolinux-final"]="0:0:755"
  ["/usr/local/bin/services"]="0:0:755"
  ["/usr/local/bin/ucode"]="0:0:755"
  ["/usr/local/bin/fsprogschk"]="0:0:755"
  ["/usr/local/bin/nouveau"]="0:0:755"
  ["/usr/local/bin/cala-launch"]="0:0:755"
  )
