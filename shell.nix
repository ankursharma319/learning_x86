{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7ac6901f5e3038d59d3e2576af445fe418291dd8.tar.gz") {}}:

pkgs.mkShell {
    nativeBuildInputs = [
        pkgs.nasm
    ];
    buildInputs = [
        pkgs.git
        pkgs.gdb
        pkgs.valgrind
        pkgs.which
    ];
}
