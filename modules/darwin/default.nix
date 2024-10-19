{ pkgs, ... }:
{
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = [ pkgs.coreutils ];
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # test if this is still needed
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
    NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;
  };
  security.pam.enableSudoTouchIdAuth = true;
  users.users.franrubio.home = "/Users/franrubio";
  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global = {
      brewfile = true;
      autoUpdate = true;
    };
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "uninstall";
    };
    masApps = { };
    taps = [ "common-fate/granted" ];
    brews = [
      "pinentry-mac"
      "granted"
    ];
    casks = [
      "raycast"
      "tiles"
      "dbeaver-community"
      "spotify"
      "notunes"
      "shottr"
      "nikitabobko/tap/aerospace"
    ];
  };
}
