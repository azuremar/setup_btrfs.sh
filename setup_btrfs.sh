#!/bin/bash

# Utwórz podwoluminy
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @var
btrfs subvolume create @snapshots

# Zamontuj główny podwolumin
mount -o noatime,space_cache,compress=zstd:3,ssd,discard=async,subvol=@ /dev/sda2 /target

# Utwórz katalogi dla innych podwoluminów
mkdir -p /target/home
mkdir -p /target/var
mkdir -p /target/.snapshots

# Zamontuj podwoluminy
mount -o noatime,space_cache,compress=zstd:3,ssd,discard=async,subvol=@home /dev/sda2 /target/home
mount -o noatime,space_cache,compress=zstd:3,ssd,discard=async,subvol=@var /dev/sda2 /target/var
mount -o noatime,space_cache,compress=zstd:3,ssd,discard=async,subvol=@snapshots /dev/sda2 /target/.snapshots

# Zamontuj partycję EFI
mkdir -p /target/boot/efi
mount /dev/sda1 /target/boot/efi

echo "Podwoluminy Btrfs zostały skonfigurowane i zamontowane!"
