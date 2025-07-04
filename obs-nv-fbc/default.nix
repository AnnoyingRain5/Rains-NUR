{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  obs-studio,
  libsForQt5,
  libdrm,
  pkg-config,
  vulkan-headers,
  libGL,
  xorg,
  vulkan-loader,
  sdl3,
  linuxKernel,
  nvidia_x11 ? linuxKernel.packages.linux_latest_libre.nvidia_x11,
}:

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

  nativeBuildInputs = [
    cmake
    pkg-config
    vulkan-headers
    libGL
    xorg.libxcb
    vulkan-loader
    nvidia_x11
  ];
  buildInputs = [
    obs-studio
    sdl3
  ];

  cmakeFlags = [ ];
  dontWrapQtApps = true;

  postFixup = ''
    echo "Adding SDL3 to RPATH of built libraries..."
    # Iterate through all .so files and add SDL3's lib path to their RPATH
    for libfile in $(find . -name "*.so"); do
      if ! patchelf --print-rpath "$libfile" | grep -q "${sdl3}/lib"; then
        echo "Patching RPATH of $libfile"
        patchelf --set-rpath "$(patchelf --print-rpath "$libfile")${lib.makeLibraryPath [ sdl3 ]}" "$libfile"
      fi
    done
  '';

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
