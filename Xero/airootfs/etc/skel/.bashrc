#
# ~/.bashrc
#
clear && fastfetch
#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Path to bat config
export BAT_CONFIG_PATH="~/.config/bat/config.conf"

# Oh-My-Posh Config
eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/xero.omp.json)"

# Special Clear Message
alias clsm='clear && figlet -c -t -f small "Welcome to XeroLinux, ${USER^^}" | lolcat'
alias xff='clear && fastfetch --config ~/.config/fastfetch/stationxero.jsonc'

# Replace stuff with bat
alias cat='bat '
alias rg='batgrep '
alias man='tldr '

#iso and version used to install ArcoLinux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

#ignore upper and lowercase when TAB completion
bind 'set completion-ignore-case on'

#systeminfo
alias probe='sudo -E hw-probe -all -upload'

# Replace ls with exa
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l='eza -lah --color=always --group-directories-first --icons' # tree listing

#available free memory
alias free='free -mt'

#continue download
alias wget='wget -c'

#readable output
alias df='df -h'

#userlist
alias userlist='cut -d: -f1 /etc/passwd'

#Pacman for software managment
alias search='pacman -Ss '
alias remove='sudo pacman -Rs '
alias install='sudo pacman -S'
alias linstall='sudo pacman -U *.pkg.tar.zst'
alias update='sudo pacman -Syyu && flatpak update'
alias clrcache='sudo pacman -Scc'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'

# Paru/Yay stuff
alias pget='paru -S '
alias yget='yay -S '
alias yrem='yay -R '
alias prem='paru -R '

#Bash aliases
alias mkfile='touch'
alias jctl='journalctl -p 3 -xb'
alias breload='cd ~ && source ~/.bashrc'
alias zreload='cd ~ && source ~/.zshrc'
alias pingme='ping -c64 github.com'
alias cls='clear && neofetch'
alias traceme='traceroute github.com'

#hardware info --short
alias hw='hwinfo --short'

## HBlock
alias ublock='sudo hblock'

#Fixes & Tools
alias rpower='sudo systemctl restart power-profiles-daemon'
alias rshell='systemctl --user restart plasma-plasmashell.service'

#youtube-dl
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#GiT  command
alias gcl='git clone '
alias gpl='git pull'

#Copy/Remove files/dirs
alias rmd='rm -r'
alias srm='sudo rm'
alias srmd='sudo rm -r'
alias cpd='cp -R'
alias scpd='sudo cp -R'

#nano
alias nz='$EDITOR ~/.zshrc'
alias cls='clear && fastfetch'
alias nbashrc='sudo nano ~/.bashrc'
alias nzshrc='sudo nano ~/.zshrc'
alias nsddm='sudo nano /etc/sddm.conf'
alias pconf='sudo nano /etc/pacman.conf'
alias mkpkg='sudo nano /etc/makepkg.conf'
alias ngrub='sudo nano /etc/default/grub'
alias smbconf='sudo nano /etc/samba/smb.conf'
alias nlightdm='sudo $EDITOR /etc/lightdm/lightdm.conf'
alias nmirrorlist='sudo nano /etc/pacman.d/mirrorlist'
alias nsddmk='sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf'

#cd/ aliases
alias home='cd ~'
alias etc='cd /etc/'
alias music='cd ~/Music'
alias vids='cd ~/Videos'
alias conf='cd ~/.config'
alias desk='cd ~/Desktop'
alias pics='cd ~/Pictures'
alias dldz='cd ~/Downloads'
alias docs='cd ~/Documents'
alias sapps='cd /usr/share/applications'
alias lapps='cd ~/.local/share/applications'

#verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'

#receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#Package Info
alias info='sudo pacman -Si '
alias infox='sudo pacman -Sii '

##Refresh Keys
alias rkeys='sudo pacman-key --refresh-keys'

### HBLOCK Stuff

alias block="sudo hblock"
alias unhblock="hblock -S none -D none"

#shutdown or reboot
alias sr='sudo reboot'
alias ssn='sudo shutdown now'

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo ''$1' cannot be extracted via ex()' ;;
    esac
  else
    echo ''$1' is not a valid file'
  fi
}
