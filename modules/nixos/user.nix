{ pkgs, username, ... }: {
  # Define user accounts - Don't forget to set a password with "passwd"
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };
}
