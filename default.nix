{ rev    ? "61f0936d1cd73760312712615233cd80195a9b47"
, sha256 ? "1fkmp99lxd827km8mk3cqqsfmgzpj0rvaz5hgdmgzzyji70fa2f8"
, pkgs   ? import (builtins.fetchTarball {
             url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
             inherit sha256; }) {
             config.allowUnfree = true;
             config.allowBroken = true;
             config.packageOverrides = pkgs: rec {
               rls = pkgs.rls.overrideDerivation (attrs: {
                 buildInputs = attrs.buildInputs ++
                   (pkgs.stdenv.lib.optional pkgs.stdenv.isDarwin
                      pkgs.darwin.apple_sdk.frameworks.Security);
               });
             };
           }
, mkDerivation ? null
}:

with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "hello";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "0jacm96l1gw9nxwavqi1x4669cg6lzy9hr18zjpwlcyb3qkw9z7f";

  cargoBuildFlags = [];

  nativeBuildInputs = [ asciidoc asciidoctor plantuml docbook_xsl libxslt ];
  buildInputs = [ cargo rustfmt rls ]
    ++ (stdenv.lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security);

  preFixup = ''
  '';

  meta = with stdenv.lib; {
    description = "Hello, world!";
    homepage = https://github.com/jwiegley/hello-rust;
    license = with licenses; [ mit ];
    maintainers = [ maintainers.jwiegley ];
    platforms = platforms.all;
  };
}
