{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    aria
    bat
    cargo
    colima
    coreutils
    curl
    direnv
    docker
    fd
    fzf
    gh
    git
    gnupg
    go
    jq
    k9s
    kubectl
    kubectl-tree
    kubectx
    kubernetes-helm
    kustomize
    mosh
    neovim
    nnn
    # nodePackages.npm
    # nodePackages.yarn
    # nodejs
    pinentry-tty
    rbw
    ripgrep
    tmux
    tree
    unzip
    watch
    zoxide
    pyenv

    # Language servers
    gopls
    lua-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    terraform-ls

    (pass.withExtensions (ext: with ext; [
      pass-otp
    ]))
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      # { name = "homebrew/foobar"; }
    ];
    brews = [
      "lastpass-cli"
      "kcaebe/homebrew-dns-heaven/dns-heaven"
      # "foobar"
    ];
    casks = [
      "alacritty" # TODO https://github.com/neovim/neovim/issues/3344
      "kitty"
      "linearmouse"
      "utm"
      "openlens"
    ];
  };

  system.defaults = {
    alf = {
      globalstate = 1;
    };
    dock = {
      orientation = "left";
      autohide = false;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  services = {
    tailscale.enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    # configureBuildUsers = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
