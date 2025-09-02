{
  description = "A yaytatata";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    sussg.url = "github:nuttycream/sussg";
  };

  outputs = {
    nixpkgs,
    sussg,
    ...
  }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
      pkgs.mkShell {
        name = "AAAAAAAAAH";
        packages = with pkgs; [
          nodejs
          zola
          sussg.packages.${system}.default
        ];
      };
  };
}
