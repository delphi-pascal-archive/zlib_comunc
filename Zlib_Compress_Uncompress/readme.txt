By: Andrea Russo, Italy, 2005.
E-mail: andrusso@libero.it

Unit zlib is icluded into the latest version of Delphi (from Delphi 6), but in old versions is
included into the Delphi cd.

Otherwise if do you want to use paszlib library change the uses into UtilityPasZlib.

If do you want to use zlib included into Delphi: uses zlib, Classes;
If do you want to use paszlib library: uses dzlib, Classes;

UtilityPasZlib is a simple library for compress and uncompress files and streams with zlib or paszlib.