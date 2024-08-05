This guide is inspired from [`mjkstra/arch_linux_installation_guide.md`](https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae)

Check UEFI mode:

```sh
# If this command prints 64 or 32 then you are in UEFI
cat /sys/firmware/efi/fw_platform_size
```

Check internet connection:
<!-- TODO: Link Wifi docs here -->
```sh
ping -c 5 archlinux.org
```

Check time and date:

```sh
timedatectl
```

Disk layout:

EFI - 512Mb
Linux - (Remaining)
    - Root subvol @
    - Home subvol @home

Use `cfdisk` to partition disk:
    - Select EFI file systems for EFI partion 
    - Select Linux File System for Root partion

eg:
```sh
cfdisk /dev/nvme0n1
```

Format disks:
```sh
# Find the efi partition with fdisk -l or lsblk. For me it's /dev/nvme0n1p1 and format it.
mkfs.fat -F 32 /dev/nvme0n1p1 -n EFI

# Find the root partition. For me it's /dev/nvme0n1p2 and format it. I will use BTRFS.
mkfs.btrfs /dev/nvme0n1p2 -L ROOT

# Mount the root fs to make it accessible
mount /dev/nvme0n1p2 /mnt
```

Mount disks:

```sh
# Create the subvolumes, in my case I choose to make a subvolume for / and one for /home. Subvolumes are identified by prepending @
# NOTICE: the list of subvolumes will be increased in a later release of this guide, upon proper testing. To learn more go to the "Things to add" chapter.
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Unmount the root fs
umount /mnt
```

- mount sobvols:

```sh
# Mount the root and home subvolume. If you don't want compression just remove the compress option.
mount -o compress=zstd,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/home
mount -o compress=zstd,subvol=@home /dev/nvme0n1p2 /mnt/home
```

- mount EFI:

```sh
mkdir -p /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
```

Package initial installation using pacstrap

```sh
pacstrap -K /mnt base base-devel linux linux-firmware git btrfs-progs grub efibootmgr grub-btrfs inotify-tools timeshift vim networkmanager pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber reflector zsh zsh-completions zsh-autosuggestions openssh man sudo
```

Generate Fstab:

```sh
# Fetch the disk mounting points as they are now ( we mounted everything before ) and generate instructions to let the system know how to mount the various disks automatically
genfstab -U /mnt >> /mnt/etc/fstab

# Check if fstab is fine
cat /mnt/etc/fstab
```

Chroot into new Arch installation:

```sh
# To access our new system we chroot into it
arch-chroot /mnt
```

Set up the time zone

# In our new system we have to set up the local time zone, find your one in /usr/share/zoneinfo mine is /usr/share/zoneinfo/Europe/Rome and create a symbolic link to /etc/localtime
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime

# Now sync the time to the hardware clock
hwclock --systohc


Set up the language and tty keyboard map

Edit /etc/locale.gen and uncomment the entries for your locales, this will "enable" ( NOT ACTIVATE ) the language but also formats for time, date, currency and other country related settings. In my case I will uncomment ( ie: remove the # ) en_US.UTF-8 UTF-8 and it_IT.UTF-8 UTF-8 because I use English as a "display" language and Italian for date, time and other formats.

# To edit I will use vim, feel free to use nano instead.
vim /etc/locale.gen

# Now generate the locales
locale-gen


Create the configuration file /etc/locale.conf and set the locale to the desired one, by setting the LANG variable accordingly. In my case I'll write LANG=it_IT.UTF-8 to apply Italian settings to everything and then override only the display language to English by setting LC_MESSAGES=en_US.UTF-8. ( if you want formats and language to stay the same DON'T set LC_MESSAGES ). More on this here

touch /etc/locale.conf
vim /etc/locale.conf


Now to make the current keyboard layout permanent for tty sessions , create /etc/vconsole.conf and write KEYMAP=your_key_map substituting the keymap with the one previously set here. In my case KEYMAP=it

vim /etc/vconsole.conf


Hostname and Host configuration

# Create /etc/hostname then choose and write the name of your pc in the first line. In my case I'll use Arch
touch /etc/hostname
vim /etc/hostname

# Create the /etc/hosts file. This is very important because it will resolve the listed hostnames locally and not over the Internet.
touch /etc/hosts

Write the following ip, hostname pairs inside /etc/hosts, replacing Arch with YOUR hostname:

127.0.0.1 localhost
::1 localhost
127.0.1.1 Arch

# Edit the file with the information above
vim /etc/hosts


Root and users

# Set up the root password
passwd

# Add a new user, in my case mjkstra.
# -m creates the home dir automatically
# -G adds the user to an initial list of groups, in this case wheel, the administration group. If you are on a Virtualbox VM and would like to enable shared folders between host and guest machine, then also add the group vboxsf besides wheel.
useradd -mG wheel mjkstra
passwd mjkstra

# Uncomment the wheel group to allow execution of any command( ie: remove the # from the wheel line below where it says something like: "Uncomment to let members of group wheel execute any action" ). if you want to use nano then write EDITOR=nano instead.
EDITOR=vim visudo


Grub configuration

Now I'll deploy grub

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB  


Generate the grub configuration ( it will include the microcode installed with pacstrap earlier )

grub-mkconfig -o /boot/grub/grub.cfg


Unmount everything and reboot

# Enable newtork manager before rebooting otherwise, you won't be able to connect
systemctl enable NetworkManager

# Exit from chroot
exit

# Unmount everything to check if the drive is busy
umount -R /mnt

# Reboot the system and unplug the installation media
reboot

# Now you'll be presented at the terminal. Log in with your user account, for me its "mjkstra".

# Enable and start the time synchronization service
timedatectl set-ntp true


Automatic snapshot boot entries update

Edit grub-btrfsd service to enable automatic grub entries update each time a snapshot is created. Because I will use timeshift i am going to replace ExecStart=... with ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto. If you don't use timeshift or prefer to manually update the entries then lookup here

sudo systemctl edit --full grub-btrfsd

# Enable grub-btrfsd service to run on boot
sudo systemctl enable grub-btrfsd

Aur helper and additional packages installation

To gain access to the arch user repository we need an aur helper, I will choose yay which also works as a pacman wrapper ( which means you can use yay instead of pacman. Cool, right ? ). Yay has a CLI, but if you later want to have an aur helper with a GUI, I advise installing pamac, which is the default on Manjaro.

To learn more about yay read here

    Note: you can't execute makepkg as root, so you need to log in your main account. For me it's mjkstra

# Install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install "timeshift-autosnap", a configurable pacman hook which automatically makes snapshots before pacman upgrades.
yay -S timeshift-autosnap


Finalization

# To complete the main/basic installation reboot the system
reboot

    After these steps you should be able to boot on your newly installed Arch Linux, if so congrats !

    The basic installation is complete and you could stop here, but if you want to to have a graphical session, you can continue reading the guide.


