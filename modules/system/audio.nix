{ pkgs, ... }:
{
  # Low-latency PipeWire with Realtime Priority
  security.rtkit.enable = true;

  security.pam.loginLimits = [
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nice"; type = "-"; value = "-11"; }
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "10-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 64;
            "default.clock.max-quantum" = 1024;
          };
        };
        "11-bluetooth-codecs" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.codecs" = [ "ldac" "aptx_hd" "aptx" "aac" "sbc_xq" "sbc" ];
          };
        };
      };
    };
  };
}
