{ pkgs }:
{
  avali-scratch = pkgs.callPackage ./avali-scratch {};
  discord-krisp-patcher = pkgs.callPackage ./discord-krisp-patcher {};
  obs-nv-fbc = pkgs.callPackage ./obs-nv-fbc {};
}