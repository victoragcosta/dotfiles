{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.service.mongodb.enable {
    package = pkgs.mongodb-ce;
    users.users.cubo.packages = with pkgs;
      [
        # mongodb-ce
        mongodb-compass
      ];
  };
}
