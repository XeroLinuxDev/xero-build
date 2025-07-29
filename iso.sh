#!/bin/bash
#set -e
##################################################################################################################
# Author: DarkXero (Unified build script)
# Website: https://xerolinux.xyz
##################################################################################################################
clear
echo
tput setaf 2
echo "################################################################### "
echo "            Welcome to the Unified XeroLinux ISO Builder            "
echo "################################################################### "
tput sgr0
echo

# --- Select Profile ---

echo "Please select which ISO to build:"
echo
echo "1) XeroLinux KDE"
echo "2) XeroLinux Gnome"
echo "3) XeroLinux Cosmic (Alpha)"
echo
read -p "Enter selection (1, 2 or 3): " choice

case "$choice" in
  1)
    desktop="kde"
    dmDesktop="plasma"
    profileFolder="XeroKDE"
    outputSubFolder="KDE"
    ;;
  2)
    desktop="gnome"
    dmDesktop="gnome"
    profileFolder="XeroG"
    outputSubFolder="Gnome"
    ;;
  3)
    desktop="cosmic"
    dmDesktop="cosmic"
    profileFolder="XeroCosmic"
    outputSubFolder="Cosmic"
    ;;
  *)
    echo "Invalid selection. Exiting."
    exit 1
    ;;
esac

isoLabel="xerolinux-${desktop}-$(date +"%Y.%m")-x86_64.iso"

# Setup paths relative to current directory
WORKDIR=$(pwd)
buildFolder="${WORKDIR}/build"
outFolder="${WORKDIR}/XeroISO/${outputSubFolder}"

archisoRequiredVersion="archiso 85-1"
archisoVersion=$(sudo pacman -Q archiso 2>/dev/null || echo "not-installed")

personalrepo=false  # Set to true if you want to add personal repo packages

mkdir -p "$outFolder"

echo "################################################################## "
echo "Building the desktop                   : $desktop"
echo "Iso label                             : $isoLabel"
echo "Archiso version installed            : $archisoVersion"
echo "Archiso version required             : $archisoRequiredVersion"
echo "Build folder                         : $buildFolder"
echo "Output folder                        : $outFolder"
echo "################################################################## "

if [ "$archisoVersion" == "$archisoRequiredVersion" ]; then
  tput setaf 2
  echo "Archiso has the correct version. Continuing..."
  tput sgr0
else
  tput setaf 1
  echo "You need to install the correct version of Archiso"
  echo "Use 'sudo downgrade archiso' or update your system"
  tput sgr0
fi

echo
tput setaf 2
echo "Phase 2 : Checking if archiso is installed and ready"
tput sgr0
echo

package="archiso"

if pacman -Qi "$package" &>/dev/null; then
  echo "Archiso is already installed"
else
  if pacman -Qi yay &>/dev/null; then
    echo "Installing $package with yay"
    yay -S --noconfirm "$package"
  elif pacman -Qi trizen &>/dev/null; then
    echo "Installing $package with trizen"
    trizen -S --noconfirm --needed --noedit "$package"
  else
    echo "No AUR helper found (yay or trizen). Please install $package manually."
    exit 1
  fi

  if pacman -Qi "$package" &>/dev/null; then
    echo "$package has been installed"
  else
    echo "$package has NOT been installed. Exiting."
    exit 1
  fi
fi

echo
echo "Saving current archiso version to readme"
sudo sed -i "s/\(^archiso-version=\).*/\1$archisoVersion/" archiso.readme || echo "Warning: archiso.readme not found, skipping."
echo

echo "Making mkarchiso verbose"
if [ -f /usr/bin/mkarchiso ]; then
  sudo sed -i 's/quiet="y"/quiet="n"/g' /usr/bin/mkarchiso
else
  echo "Warning: /usr/bin/mkarchiso not found, skipping verbose update."
fi

echo
tput setaf 2
echo "Phase 3 : Cleaning and preparing build folder"
tput sgr0

echo "Deleting existing build folder if present (this may take some time)..."
[ -d "$buildFolder" ] && sudo rm -rf "$buildFolder"

echo "Copying profile folder '$profileFolder' to build folder"
mkdir -p "$buildFolder"
cp -r "${profileFolder}/" "${buildFolder}/${profileFolder}"

profileBuildPath="${buildFolder}/${profileFolder}"

echo
tput setaf 2
echo "Phase 4 : Managing packages and personal repo"
tput sgr0

# Remove old packages files
rm -f "${profileBuildPath}/packages.x86_64"
rm -f "${profileBuildPath}/packages-personal-repo.x86_64"

echo "Copying fresh packages.x86_64 file"
echo
cp -f "${profileFolder}/packages.x86_64" "${profileBuildPath}/packages.x86_64"

if [ "$personalrepo" = true ]; then
  echo "Appending packages from personal repository to packages.x86_64"
  printf "\n" | sudo tee -a "${profileBuildPath}/packages.x86_64"
  cat "${profileFolder}/packages-personal-repo.x86_64" | sudo tee -a "${profileBuildPath}/packages.x86_64"

  echo "Adding personal repo to pacman.conf"
  echo
  printf "\n" | sudo tee -a "${profileBuildPath}/pacman.conf"
  printf "\n" | sudo tee -a "${profileBuildPath}/airootfs/etc/pacman.conf"
  cat personal-repo | sudo tee -a "${profileBuildPath}/pacman.conf"
  cat personal-repo | sudo tee -a "${profileBuildPath}/airootfs/etc/pacman.conf"
fi

echo
tput setaf 2
echo "Phase 5 : Updating references in profile files"
tput sgr0

oldname1='iso_name="xerolinux'
newname1="iso_name=\"xerolinux"

oldname2='iso_label="xerolinux'
newname2="iso_label=\"xerolinux"

oldname3='XeroLinux'
newname3='XeroLinux'

oldname4='XeroLinux'
newname4='XeroLinux'

echo "Updating profiledef.sh"
echo
sed -i "s/${oldname1}/${newname1}/g" "${profileBuildPath}/profiledef.sh"
sed -i "s/${oldname2}/${newname2}/g" "${profileBuildPath}/profiledef.sh"

echo "Updating airootfs files"
echo
sed -i "s/${oldname3}/${newname3}/g" "${profileBuildPath}/airootfs/etc/dev-rel"
sed -i "s/${oldname4}/${newname4}/g" "${profileBuildPath}/airootfs/etc/hostname"

# Adding missing sddm.conf update step you had in your KDE script
if [ -f "${profileBuildPath}/airootfs/etc/sddm.conf" ]; then
  # Assuming oldname5/newname5 are same as oldname4/newname4 here (or change accordingly if different)
  oldname5='XeroLinux'
  newname5='XeroLinux'
  sed -i "s/${oldname5}/${newname5}/g" "${profileBuildPath}/airootfs/etc/sddm.conf"
fi

echo "Adding build timestamp in /etc/dev-rel"
echo
date_build=$(date)
echo "Iso build on : $date_build"
sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/" "${profileBuildPath}/airootfs/etc/dev-rel"

echo
tput setaf 2
echo "Phase 7 : Building the ISO image (can take a while)"
tput sgr0
echo
[ -d "$outFolder" ] || mkdir -p "$outFolder"
cd "$profileBuildPath" || { echo "Profile build path not found!"; exit 1; }

sudo mkarchiso -v -w "$buildFolder" -o "$outFolder" "$profileBuildPath"

echo
tput setaf 2
echo "Phase 8 : Creating checksums and moving pkglist"
tput sgr0
echo
cd "$outFolder" || { echo "Output folder not found!"; exit 1; }

echo "Creating checksums for: $isoLabel"
sha1sum "$isoLabel" | tee "$isoLabel.sha1"
sha256sum "$isoLabel" | tee "$isoLabel.sha256"
md5sum "$isoLabel" | tee "$isoLabel.md5"

echo
echo "Copying pkglist.x86_64.txt"
cp "${buildFolder}/iso/arch/pkglist.x86_64.txt" "${outFolder}/${isoLabel}.pkglist.txt"

echo
tput setaf 2
echo "Phase 9 : Cleaning up..."
tput sgr0
echo
[ -d "$buildFolder" ] && sudo rm -rf "$buildFolder"

echo
tput setaf 2
echo "DONE"
echo
echo "- Check your output folder : $outFolder"
tput sgr0
echo
