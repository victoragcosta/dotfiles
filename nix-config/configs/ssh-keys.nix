# Installs every SSH public key dropped into the flake's `keys/` directory as
# an authorized key for `cubo` on every host in the flake. Each regular,
# non-hidden file is read line by line; blank lines and `#` comments are
# ignored, so one key per line works as expected.
#
# To add or rotate a key: copy the `.pub` file into `keys/`, remove any key file
# you no longer want, and `git add` the change — flakes only see Git-tracked
# files, so an untracked key file is invisible to the evaluation.
{
  lib,
  ...
}:
let
  keysDir = ../keys;

  keyFiles = lib.filter (name: !(lib.hasPrefix "." name)) (
    builtins.attrNames (
      lib.filterAttrs (_name: type: type == "regular") (
        if builtins.pathExists keysDir then builtins.readDir keysDir else { }
      )
    )
  );

  keyLines = lib.concatMap (
    name:
    builtins.filter (line: line != "" && !(lib.hasPrefix "#" line)) (
      map lib.trim (lib.splitString "\n" (builtins.readFile (keysDir + "/${name}")))
    )
  ) keyFiles;
in
{
  users.users.cubo.openssh.authorizedKeys.keys = keyLines;

  # Password and keyboard-interactive auth are disabled on cubopi, so an empty
  # key set would make that image unreachable over the network. Refuse to
  # evaluate without keys on any host.
  assertions = [
    {
      assertion = keyLines != [ ];
      message = ''
        No SSH public keys found in keys/.

        SSH on cubopi is key-only, so an image built without keys cannot be
        reached over the network. Add at least one public key file to `keys/`
        at the flake root and run `git add` on it (flakes ignore untracked
        files).
      '';
    }
  ];
}
