{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.services.mongodb.enable {
    services.mongodb = { package = pkgs.mongodb-ce; };
    users.users.cubo.packages = with pkgs;
      [
        # mongodb-ce
        mongodb-compass
      ];
  };
}
