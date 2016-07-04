{ stdenv, lib, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "mop-${version}";
  version = "0.2.0";
  rev = "bc666ec165d08b43134f7ec0bf29083ad5466243";
  goPackagePath = "github.com/michaeldv/mop";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/michaeldv/mop";
    sha256 = "0zp51g9i8rw6acs4vnrxclbxa5z1v0a0m1xx27szszp0rphcczkx";
  };
}
