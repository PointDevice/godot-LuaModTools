

{
  description = "Godot Build";
  nixConfig.bash-prompt = "[nix(my-project)] ";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "My-project build environment";
        buildInputs = with pkgs;[
          scons
          pkg-config
          xorg.libX11
          xorg.libXcursor
          xorg.libXext
          xorg.libXfixes
          xorg.libXi
          xorg.libXinerama
          libxkbcommon
          xorg.libXrandr
          xorg.libXrender
          libgcc
          wayland
          wayland-scanner
          vulkan-loader
          alsa-lib
		  fontconfig

          python39
        ];
	    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
          wayland
		  vulkan-loader
		  libxkbcommon
		  fontconfig
        ]);
        shellHook = ''
          echo "Welcome in $name"
          export NIX_SHELL_PACKAGES="Godot Build"
        '';
      };
    };
}

