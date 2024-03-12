{
  lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "swayfader";
  version = "2024-03-12";
  src = fetchFromGitHub {
    owner = "jake-stewart";
    repo = pname;
    rev = "55110032568527638a3d48091749c2ff4aaa4f2c";
    hash = "sha256-eg334cIPlUd+PAZG9F2DVllZVb/ldIhLp1e/f4i6Cz0=";
  };
  pyproject = false;
  propagatedBuildInputs = with python3Packages; [
    i3ipc
  ];

  doCheck = false;
  doInstallCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/swayfader.py $out/bin/swayfader
    chmod +x $out/bin/swayfader
  '';

  meta = with lib; {
    description = "Window fading script in Swaywm ";
    homepage = "https://github.com/jake-stewart/swayfader";
    license = licenses.mit;
    mainProgram = "swayfader";
  };
}
