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


### package installation
- install specifc version of package with apt
```
apt-get install <pkgname>=<pkgversion>
```
- 

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

