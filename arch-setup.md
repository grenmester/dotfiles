# Arch Linux Setup

This document describes my personal workflow for setting up my [Arch
Linux][arch] environment. This setup guide is intended to function as more of a
checklist than a tutorial and assumes you have a working base installation of
Arch Linux. As such, please refer to another resource such as the excellent
[ArchWiki installation guide][arch-install] for an installation reference.

## Base Installation

These three packages should have been installed during the base installation of
Arch Linux.

    pacman -S base linux linux-firmware

This package includes useful commands and utilities such as `grep` and `sudo`.

    pacman -S base-devel

This package includes headers and scripts for building modules for the Linux
kernel.

    pacman -S linux-headers

## Boot Loader

A [boot loader][boot-loader] such as [GRUB][grub] is needed to load and start
the boot time tasks and processes of the operating system. For dual booting,
the `os-prober` package can detect other filesystems with operating systems on
them, and work out how to boot other linux installs. The `dosfstools` and
`mtools` packages are useful for working with filesystems.

    pacman -S grub os-prober dosfstools mtools

Be sure to [install and configure GRUB][grub-install] after installing the
packages.

### Microcode Updates

If you have an Intel or AMD CPU, enable [microcode updates][ucode] in addition.
For Intel CPUs, the appropriate package is `intel-ucode`. After installing the
microcode package, regenerate the GRUB config to activate loading the microcode
update

    pacman -S intel-ucode
    grub-mkconfig -o /boot/grub/grub.cfg

## Network Manager

To configure network connections, install a network manager such as
[NetworkManager][networkmanager]. Be sure to enable the NetworkManager daemon
after installation.

    pacman -S networkmanager
    systemctl enable NetworkManager

## Arch User Repository

The [Arch User Repository][aur] (AUR) contains packages submitted by users. To
install these user contributed packages, an AUR helper such as [Yay][yay] is
required.

    pacman -S git
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
    cd .. && rm -rf yay

## Graphical Environment

### Display Server

Install a [display server][display-server] such as [Xorg][xorg] to enable using
a graphical user interface. The `xorg-xinit` package allows you to manually
start an Xorg display server with the `startx` command using the `~/.xinitrc`
configuration file.

    pacman -S xorg xorg-xinit

The default `.xinitrc` should be found in `/etc/X11/xinit/xinitrc`.

### Graphics Driver

Install the appropriate graphics drivers to allow your computer to use the
graphics hardware. [Check which packages are recommended][drivers] for your
graphics card and install the packages. For Nvidia GPUs, the appropriate
package is `nvidia`.

    pacman -S nvidia

A system reboot may be required to enable the driver.

### Window Manager

A [window manager][window-manager] is a more lightweight alternative to a
[desktop environment][desktop-environment]. My preferred window manager is
[XMonad][xmonad]. The XMonad configuration file is in `~/.xmonad/xmonad.hs`.
The `xmonad-contrib` package contains third party extensions for XMonad.

    pacman -S xmonad xmonad-contrib

### Display Manager

Install a [display manager][display-manager] such as [LightDM][lightdm] to
automate starting the display server. A [greeter][greeter] such as
`lightdm-gtk-greeter` will also be required to display the GUI greeter prompt.
Be sure to enable LightDM so it will be started at boot.

    pacman -S lightdm lightdm-gtk-greeter
    systemctl enable lightdm

Symlink `~/.xprofile` to `~/.xinitrc` since LightDM sources `~/.xprofile` and
we also want to be able to start our own display server.

    ln -s ~/.xinitrc ~/.xprofile

## Sound

The `alsa-utils` package contains among other utilities the `alsamixer` and
`amixer` utilities. [PulseAudio][pulseaudio] is a general purpose sound server
intended to run as a middleware between your applications and your hardware
devices.

    pacman -S alsa-utils pulseaudio pulseaudio-alsa

## Appearance

To customize your desktop, you may want to change the font, [GTK theme][gtk],
and icon theme. The [LXAppearance][lxappearance] GUI interface can be
used to change the GTK theme, icon theme, and more.

    yay -S nerd-fonts-fira-code
    pacman -S lxappearance
    yay -S gtk-theme-numix-solarized
    pacman -S papirus-icon-theme

[arch]: https://www.archlinux.org
[arch-install]: https://wiki.archlinux.org/index.php/installation_guide
[boot-loader]: https://wiki.archlinux.org/index.php/Arch_boot_process
[grub]: https://www.gnu.org/software/grub
[grub-install]: https://wiki.archlinux.org/index.php/GRUB
[ucode]: https://wiki.archlinux.org/index.php/microcode
[networkmanager]: https://wiki.archlinux.org/index.php/NetworkManager
[aur]: https://aur.archlinux.org
[yay]: https://github.com/Jguer/yay
[display-server]: https://www.wikipedia.com/en/Display_server
[xorg]: https://www.x.org/wiki
[drivers]: https://wiki.archlinux.org/index.php/xorg#Driver_installation
[window-manager]: https://wiki.archlinux.org/index.php/window_manager
[desktop-environment]: https://wiki.archlinux.org/index.php/Desktop_environment
[xmonad]: https://xmonad.org
[display-manager]: https://wiki.archlinux.org/index.php/display_manager
[lightdm]: https://wiki.archlinux.org/index.php/LightDM
[greeter]: https://wiki.archlinux.org/index.php/LightDM#Greeter
[pulseaudio]: https://www.freedesktop.org/wiki/Software/PulseAudio
[gtk]: https://www.gtk.org
[lxappearance]: https://wiki.lxde.org/en/LXAppearance
