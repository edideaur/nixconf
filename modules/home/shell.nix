{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # No greeting
      set fish_greeting

      # Colors from quickshell dynamic palette
      if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
          cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
      end

      # Clear fix
      alias clear "printf '\033[2J\033[3J\033[1;1H'"
      alias celar "printf '\033[2J\033[3J\033[1;1H'"
      alias claer "printf '\033[2J\033[3J\033[1;1H'"

      # Core aliases
      alias q 'qs -c ii'
      alias rm 'fast-rm'
      alias ls 'eza --icons=auto'
      alias ll 'eza -la --icons=auto'

      # Nix shortcuts
      alias nrs 'sudo nixos-rebuild switch --flake /home/edideaur/Documents/nix#T14'
      alias nrb 'nixos-rebuild build-vm --flake /home/edideaur/Documents/nix#T14'
      alias nrt 'sudo nixos-rebuild test --flake /home/edideaur/Documents/nix#T14'
      alias nru 'nix flake update --flake /home/edideaur/Documents/nix'
      alias ncg 'nix-collect-garbage -d && sudo nix-collect-garbage -d'

      # Fast qBittorrent-nox CLI alias
      alias qbt 'qbittorrent-nox'

      # direnv hook
      if type -q direnv
          direnv hook fish | source
      end
    '';
  };

  # Starship prompt with transient prompt support
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
      directory = {
        truncation_length = 4;
        style = "bold cyan";
      };
      git_branch = {
        style = "bold purple";
      };
      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
      };
    };
  };

  # Direnv with Nix integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
