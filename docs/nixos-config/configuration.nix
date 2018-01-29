# configuration.nix
# Machine: CLASSIFIED

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
  	./hardware-configuration.nix
  ];

  # rxvt fixed the backspace and delete key problem!
  #environment.variables.TERM = "term";
  environment.variables.TERM = "rxvt";
  # TODO When logging in via ssh it should be set to:
  # Is it possible to do this thru fish config?
  environment.variables.TERM = "iterm2";

  ### Boot Settings ###
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  # Drive to install GRUB on.
  # Does it know to use the ef00 EFI partition on /dev/sda2?
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for UEFI only
  loader.efi.efiSysMountPoint = "/boot/efi";

  ### Networking ###
  networking.hostName = "classified"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true; TODO what is this?
  # networking.nameservers = ["208.67.222.222" "208.67.220.220"];

  nix.extraOptions = "binary-caches-parallel-connections = 5";

  # Select internationalisation properties.
  # TODO might this help with keyboard issues?
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget curl vim fish
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };

  users.extraUsers.bryan = {
    name = "bryan";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video"
      "networkmanager" "systemd-journal"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/bryan";
    shell = "/run/current-system/sw/bin/bash";
    # TODO use a file instead. reference guest.nix
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDa9ZfwADEW6fmUs+1IQb8/kmi9winuu+zsFPV90P2igrWvq/lN2MvNHdTicrsjKgIwWzpHNxAVh0/HS8mQH2CXg40XA5vGZjpWKQ9RUxCs6mUKk93kHlSkYluIyyRVtiPH+4gAEMaQDdkKjpUqW6dUAJklymtZs8mU48DtM2DcE+JkLdvyr5WzDZaHLiHGdlwWvTZ4l+Vx2gNmNuzQS3cKoFCnZlYTXHnNCtB50sHj1k8KIOp58T+3GF9mwDH3DbiPpVVvxDbsz5qkDK1Rz6hCO6W6tYY/sXGslxt67LnFGhLJLU7T+6atNHHtOLRrPTEAM0EBgYD5QBGW6lbp2ZL7uf7Yeuboe5WYCUfo/4CPGfmQA+LbZT1imchEqWfksp770OdbYtEAqYYsbDgLawDGCXnXHWkxEUsyOC0GkklkZ5y9cIrjAe50LPYvx7v7+pxmcI6npgy1/xY4YFYLI85GQsbEFvnFrI1UUJttp5pjeKJbpGaVIn9lOMkgfFMM2O84qFGPtdED1hLnbCxYW5I2OpAr5Amj+abXNSV4nlW/M/o2hgIWA4v0KiqsK9GrCiEzxNViHSWdWPeM5n6+zn2y57WTj8YQ3j7S0ieoOZpWzmG4wdfqnINU7CWgvau49p9rNUr0SYEGkXfYdI8hEpErUqr2oYTqoVSt/Qiy4ArUlw== bryan@Bryans-Air"
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}