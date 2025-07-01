{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim # Editeur de texte puissant
    

    #IDEs
    jetbrains.webstorm #Web IDE from JetBrains
    jetbrains.phpstorm #PHP IDE from JetBrains
    jetbrains.rust-rover #Rust IDE from JetBrains
    jetbrains.ruby-mine #Ruby IDE from JetBrains
    jetbrains.rider #.NET IDE from JetBrains
    jetbrains.pycharm-professional #Python IDE from JetBrains
    jetbrains.idea-ultimate #Java, Kotlin, Groovy and Scala IDE from jetbrains
    jetbrains.goland #Go IDE from JetBrains
    jetbrains.gateway #Remote development for JetBrains products
    jetbrains.clion #C/C++ IDE from JetBrains
    jetbrains-toolbox #Jetbrains Toolbox
  ];
}

