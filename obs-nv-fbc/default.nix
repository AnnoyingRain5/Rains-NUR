{ lib, stdenv, fetchFromGitHub, cmake, obs-studio, libsForQt5, libdrm, pkg-config, vulkan-headers, libGL, xorg, vulkan-loader, linuxKernel }:

let
  # This is the directory that contains 'obs' and 'util'
  obsBaseIncludeDir = "${obs-studio}/include";
in
stdenv.mkDerivation rec {
  pname = "obs-nvfbc-v30";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "obs-nvfbc-v30";
    rev = "131a295f55492db4ed457148b8426817908d0089";
    sha256 = "sha256-w2Ph44DobSx4fwsU1UHevcuczeglrZ7ktuxlJdzeCVE=";
  };

  nativeBuildInputs = [ cmake pkg-config vulkan-headers libGL xorg.libxcb vulkan-loader linuxKernel.packages.linux_latest_libre.nvidia_x11 ];
  buildInputs = [ obs-studio ];

  cmakeFlags = [];
  dontWrapQtApps = true;

  
  installPhase = ''
    mkdir -p $out/lib/obs-plugins
    cp libobs-nvfbc-pre.so $out/lib/obs-plugins/libobs-nvfbc-pre.so
    cp libobs-nvfbc.so $out/lib/obs-plugins/libobs-nvfbc.so
  '';

  meta = with lib; {
    description = "OBS Studio (v30+) plugin for NVIDIA'S Frame Buffer Capture (NvFBC) API for Linux.";
    homepage = "https://github.com/PancakeTAS/obs-nvfbc-v30";
    license = licenses.gpl3;
    platforms = [
      "x86_64-linux"
      "i686-linux"
    ];
  };
}