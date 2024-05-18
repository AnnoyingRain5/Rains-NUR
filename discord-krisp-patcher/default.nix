{ lib
, python3Packages
}:

python3Packages.buildPythonApplication rec {
    pname = "discord-krisp-patcher";
    version = "0.1.0";
    format = "other";

    propagatedBuildInputs = [
        # List of dependencies
        python3Packages.capstone
        python3Packages.pyelftools
    ];

    # Do direct install
    #
    # Add further lines to `installPhase` to install any extra data files if needed.
    dontUnpack = true;
    installPhase = ''
        install -Dm755 ${./${pname}.py} $out/bin/${pname}
    '';
}
}