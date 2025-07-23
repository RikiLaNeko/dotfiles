{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
      scrcpy
      android-tools
      android-studio-tools
      aapt
    ];

    services.udev.packages = [ pkgs.android-udev-rules ];

    environment.variables = {
      ANDROID_SDK_ROOT = "/home/dedsec/Android/Sdk";
      ANDROID_HOME = "/home/dedsec/Android/Sdk";
    };
}
