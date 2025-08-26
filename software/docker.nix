{ pkgs, ... }:
{

  users.users.nixy.extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;

    storageDriver = "btrfs";
  };

  environment.systemPackages = with pkgs; [
    docker-client
    docker-compose
  ];
}
