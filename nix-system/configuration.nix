# Edit this configuration filkee to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.openrazer.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };

  security.rtkit.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [pkgs.hplip];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  console.keyMap = "pl2";
  services.getty.autologinUser = "max";

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialScript = ./init.sql;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    pavucontrol
    home-manager
    openrazer-daemon
  ];

  programs.hyprland.enable = true;

  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = ["networkmanager" "wheel" "storage" "plugdev" "openrazer" "scanner" "lp" "docker"];
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024; # 16GB
    }
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.extraOptions = ''
    trusted-users = root max
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';
}
