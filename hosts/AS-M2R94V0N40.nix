{ pkgs, ... }:

let
  username = "kietran";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "royal-tsx"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../files/alacritty.yml;
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;

      home.file.".zshrc".text = builtins.readFile ../files/.zshrc;
      home.file.".zshenv".text = builtins.readFile ../files/.zshenv;
      home.file.".p10k.zsh".text = builtins.readFile ../files/.p10k.zsh;
      home.packages = with pkgs; [
        argocd
        azure-cli
        cmctl
        istioctl
        jira-cli-go
        kubelogin
        sops
        terragrunt
        tflint
        yq-go
      ];
    };
  };
}
