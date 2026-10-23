{ pkgs, ... }:
{
  networking.hostName = "T14";
  networking.hostId = "8425e340"; # Stable 32-bit host identifier required by ZFS

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  # Strictly closed firewall (no open incoming ports)
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # NextDNS via systemd-resolved (DNS-over-TLS)
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "true";
    settings = {
      Resolve = {
        DNS = [
          "45.90.28.0#2a7252.dns.nextdns.io"
          "2a07:a8c0::#2a7252.dns.nextdns.io"
          "45.90.30.0#2a7252.dns.nextdns.io"
          "2a07:a8c1::#2a7251.dns.nextdns.io"
        ];
        DNSOverTLS = "yes";
        Cache = "yes";
      };
    };
  };

  # Mullvad VPN daemon
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };

  # Cloudflare Warp daemon
  services.cloudflare-warp.enable = true;
}
