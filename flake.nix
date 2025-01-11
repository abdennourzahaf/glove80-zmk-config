{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    glove80-zmk = {
      url = "github:moergo-sc/zmk/3111d4200d87662097dd67061174689c5a1625eb";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    glove80-zmk,
    ...
  }: {
    packages.x86_64-linux.default = let
      firmware = import glove80-zmk {pkgs = nixpkgs.legacyPackages.x86_64-linux;};
      glove80_lh = firmware.zmk.override {
        board = "glove80_lh";
        keymap = ./glove80.keymap;
      };
      glove80_rh = firmware.zmk.override {
        board = "glove80_rh";
        keymap = ./glove80.keymap;
      };
    in
      firmware.combine_uf2 glove80_lh glove80_rh;
  };
}
