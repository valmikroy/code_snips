### for .deb

- get list of files inside .deb
```
dpkg -c <deb file>
```



### package installation
- install specifc version of package with apt
```
apt-get install <pkgname>=<pkgversion>
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
