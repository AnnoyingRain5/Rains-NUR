{ pkgs }:
{
  avali-scratch = pkgs.callPackage ./avali-scratch {};
  discord-krisp-patcher = pkgs.callPackage ./discord {};
}