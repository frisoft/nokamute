{ lib, rustPlatform, pkg-config, stdenv, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "nokamute";
  version = "1.0.0";

  src = ./.;

  cargoLock = { lockFile = ./Cargo.lock; };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Security
  ];

  meta = with lib; {
    description = "Nokamute is a hive AI focused on speed.";
    license = licenses.mit;
    maintainers = with maintainers; [ "Eric Roshan-Eisner" ];
  };
}
