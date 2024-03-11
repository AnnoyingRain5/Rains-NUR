{ stdenv, lib }:

stdenv.mkDerivation rec {
    name = "avali-scratch";
    version = "1.0";
    src = lib.fileset.toSource {
      root = ./.;
      fileset = ./.;
    };
    buildPhase = '''';
    installPhase = ''
        ls
        mkdir -p $out/share/fonts/truetype/avali-scratch
        install -m444 -Dt $out/share/fonts/truetype/avali-scratch avali-scratch.ttf
        install -m444 -Dt $out/share/fonts/truetype/avali-scratch license
        #cp font/avali-scratch.ttf $out/share/fonts/truetype/avali-scratch
    '';
}
