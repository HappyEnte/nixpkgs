{ stdenv, fetchurl, patchelf, makeWrapper, xorg, gcc }:

assert stdenv.isLinux;

stdenv.mkDerivation rec {
   name = "SMCIPMITool-${version}";
   version = "2.15.0";

   src = fetchurl {
     url = "ftp://ftp.supermicro.com/utility/SMCIPMItool/Linux/SMCIPMITool_2.15.0_build.160122_bundleJRE_Linux_x64.tar.gz";
     sha256 = "1bicv1arl2m5pp0kwn9qn952c09dnswk28prv8mjikhax5xgfllx";
   };

   buildInputs = [ patchelf makeWrapper ];

   buildPhase = with xorg; ''
     patchelf --set-rpath "${stdenv.lib.makeLibraryPath [ libX11 libXext libXrender libXtst libXi ]}" ./jre/lib/amd64/xawt/libmawt.so
     patchelf --set-rpath "${stdenv.cc.cc.lib}/lib" ./libiKVM64.so
     patchelf --set-rpath "${stdenv.lib.makeLibraryPath [ libXcursor libX11 libXext libXrender libXtst libXi ]}" --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" ./jre/bin/javaws
     patchelf --set-rpath "${gcc.cc}/lib:$out/jre/lib/amd64/jli" --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" ./jre/bin/java
   '';

   installPhase = ''
     mkdir -p $out/bin

     cp -R . $out/
     cd $out/bin
     ln -s $out/SMCIPMITool
     chmod +x $out/bin/SMCIPMITool
   '';

   meta = with stdenv.lib; {
    license = licenses.unfree;
   };
}
