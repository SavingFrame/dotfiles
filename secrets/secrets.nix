let
  nixy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJusix/BIkwAnkVgfFQTM8V4MlC9gJ4wdu1xCYBV4odY";

  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzmLjcEiXSJkG4WDI09TFbNOJR2p9rFD95H0U87aEJA root@nixos";
  allKeys = [
    nixy
    system
  ];
in
{
  "secret1.age".publicKeys = allKeys;
  "bw.age".publicKeys = allKeys;
}
