{ lib
, fetchFromGitHub
, rustPlatform
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "dottor";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "CozyPenguin";
    repo = pname;
    rev = "913b0bc9b83a16a1eccb89008805ef9ceea82108";
    sha256 = "sha256-16iIeFIcSmkEDlmPH0c25e1KMV6quZCHD4ktvb983sQ=";
  };

  cargoSha256 = "sha256-bRzsyq2pFINcJ7MnJFqNOzoPtc7xfV8PafiHkoFFcoY=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "A simple dotfiles manager";
    homepage = "https://github.com/CozyPenguin/dottor";
    license = licenses.mit;
    mainProgram = "dottor";
  };
}
