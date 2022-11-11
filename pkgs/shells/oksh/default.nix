{ stdenv, lib, fetchFromGitHub, buildPackages }:

stdenv.mkDerivation rec {
  pname = "oksh";
  version = "7.2";

  src = fetchFromGitHub {
    owner = "ibara";
    repo = pname;
    rev = "${pname}-${version}";
    sha256 = "sha256-3EIWFlL2TJiRfAZ7kWtt2iEB2yAnTWbuf5LlFJjXdgk=";
  };

  strictDeps = true;

  postPatch = lib.optionalString (stdenv.buildPlatform != stdenv.hostPlatform) ''
    substituteInPlace configure --replace "./conftest" "echo"
  '';

  configureFlags = [ "--no-strip" ];

  meta = with lib; {
    description = "Portable OpenBSD ksh, based on the Public Domain Korn Shell (pdksh)";
    homepage = "https://github.com/ibara/oksh";
    license = licenses.publicDomain;
    maintainers = with maintainers; [ siraben ];
    platforms = platforms.all;
  };

  passthru = {
    shellPath = "/bin/oksh";
  };
}
