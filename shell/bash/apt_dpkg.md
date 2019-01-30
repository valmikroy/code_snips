### for .deb

- get list of files inside .deb
```
dpkg -c <deb file>
```
- extract files out of debian package
```
dpkg-deb -x ./path/to/test.deb ./path/to/destination

```
- get version of deb file
```
 dpkg -f ./path/to/test.deb Version
```

- get list of depedencies with version numbers for deb file
```
dpkg -I ./path/to/test.deb
```
- remove broken deb package
```
dpkg --remove --force-remove-reinstreq package_name 
```
- to extract pre/post scripts of debian package
```
# this will create DEBIAN folder with all control files
dpkg -e package.deb
```


### package installation
- install specifc version of package with apt
```
apt-get install <pkgname>=<pkgversion>
```
- get list of availble versions of given package in repository 
```
apt-cache madison <pkgname>
```

### for installed package

- reinstall debian package 
```
apt-get install --reinstall  <pkg name which is already installed on host>
```

- given file belongs to which installed package
```
dpkg -S <filename>
```
- Get version of installed package
```
dpkg-query --showformat='${Version}\n' --show <pkg_name>
```
- Get depedent package name list
```
apt-cache showpkg <package_name>
```
