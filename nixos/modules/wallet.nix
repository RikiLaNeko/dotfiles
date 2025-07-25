{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
      feather #Free Monero desktop wallet
      wasabiwallet #Privacy focused Bitcoin wallet
    ];
  }
