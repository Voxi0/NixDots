{ pkgs, username, ... }: {
  # Define user accounts - Don't forget to set a password with "passwd"
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
