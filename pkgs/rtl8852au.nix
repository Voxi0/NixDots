{ stdenv, fetchFromGitHub, kernel }: stdenv.mkDerivation rec {
  pname = "rtl8852au";
  version = "unstable-2024-06-01";
	meta = {
    description = "Realtek RTL8852AU driver for TP-Link Archer TX20UH";
    license = stdenv.lib.licenses.gpl2;
    platforms = [ "x86_64-linux" ];
  };

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8852au";
    rev = "master";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace after first build
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;
  buildPhase = ''
    make KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
  '';
  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
    cp 8852au.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
  '';
}
