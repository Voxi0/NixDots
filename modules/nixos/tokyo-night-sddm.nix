{ pkgs, ... }: let
  outputDir = "/share/sddm/themes/tokyo-night-sddm";
in pkgs.stdenvNoCC.mkDerivation {
  name = "tokyo-night-sddm";
  src = pkgs.fetchFromGithub {
    owner = "siddrs";
    repo = "tokyo-night-sddm";
    rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
    sha256 = "0c9rnc8a0ihacx16dlw1464fjaarhlqvvwbk7wbca2c6jyhplrsw";
  };
  installPhase = ''
    mkdir -p ${outputDir}
    cp -r ./* ${outputDir}
  '';
}
