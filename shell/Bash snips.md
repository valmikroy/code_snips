Bash snips

- Multiple lines stored in bash variables
  ```shell
  USAGE=$(cat <<-END
      This is line one.
      This is line two.
      This is line three.
  END
  )
  ```

  



- Run command is parallel
  ```
  printf %s\\n {0..99} | xargs -n 1 -P 8 script-to-run.sh
  ```

- Date
  [strftime](https://man7.org/linux/man-pages/man3/strftime.3.html)

  ```
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
  ```

- Curl timing 
  ```
  curl -I -s -k  -o /dev/null  -w 'Total: %{time_appconnect}s\n' https://google.com
  
  curl -w @- -o /dev/null -s "$@" <<'EOF'
      time_namelookup:  %{time_namelookup}\n
         time_connect:  %{time_connect}\n
      time_appconnect:  %{time_appconnect}\n
     time_pretransfer:  %{time_pretransfer}\n
        time_redirect:  %{time_redirect}\n
   time_starttransfer:  %{time_starttransfer}\n
                      ----------\n
           time_total:  %{time_total}\n
  EOF
  ```

- Find command with exlucsion 
  ```
  find . -not -path "./.git/*"
  ```

- Replace space with underscore 
  ```
   openssl version | tr -s ' ' '_'
  ```

- Yum source rpm 
  ```
  yum repolist all
  sudo yum-config-manager --enable <source_repo>
  
  yumdownloader --source <download source rpm package>
  ```
  
- Ssh keygen
  ```
  ssh-keygen -f ~/.ssh/id_ecdsa -t ecdsa -b 521 -C "blah"
  ```
  
- Simple logging function 
  ```shell
  exec 3>&1
  
  log ()
  {
      echo "Log message: $1" 1>&3
  }
  
  get_animals()
  {
      log "Fetching animals"
      echo "cat dog mouse"
  }
  
  animals=`get_animals`
  echo Animals: $animals
  ```
  
- Loop through command output 
  ```shell
  while IFS= read -r line
  do
    echo $line
  done < <(cat $FILE | grep blah)
  ```
  
- mtr report generation command 
  ```
  
  
  $ sudo mtr -c 50 <hostname> -r -w -n
  Start: 2024-04-30T14:57:05-0700
  HOST: <>              Loss%   Snt   Last   Avg  Best  Wrst StDev
    1.|-- ???           100.0    50    0.0   0.0   0.0   0.0   0.0
    2.|-- ???           100.0    50    0.0   0.0   0.0   0.0   0.0
    3.|-- ???           100.0    50    0.0   0.0   0.0   0.0   0.0
    4.|-- 10.196.255.74  2.0%    50   38.5  38.9  33.9  60.7   6.2
    5.|-- ???           100.0    50    0.0   0.0   0.0   0.0   0.0
    6.|-- 10.255.52.28   0.0%    50   34.3  37.7  33.8  49.4   3.9
    7.|-- 140.91.234.93  2.0%    50   37.9  38.2  34.0  68.5   6.1
    8.|-- ???           100.0    50    0.0   0.0   0.0   0.0   0.0
  ```

- Netcat equivalent of telnet
  ```
  nc -vzw5 <hostname> <port>  
  ```
  
- Install python virtualenv
  ```
  python3 -m venv .venv
  source .venv/bin/activate
  deactivate
  ```
  
- Freeze and Thaw your python environment 
  ```
  pip freeze > requirements.txt
  pip install -r requirements.txt
  ```
  
- Flatten the yaml file 
  ```shell
  yq '.. | select(tag != "!!seq" and tag != "!!map") | {path | join("."): .}' values.yaml
  ```
  
- Nmap quick port scan 
  ```shell
  nmap -p0- -v -A -T4 <hostname>
  
  # scan the local network subnet
  nmap -sn  10.0.0.0/24
  
  ```
  
- quick IP address
  ```shell
  ip -f inet addr show enp2s0 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'
  ```

- Write a large amount of data in the file - [credits](https://superuser.com/questions/792427/creating-a-large-file-of-random-bytes-quickly)
  ```shell
  openssl enc -aes-256-ctr -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" -nosalt < /dev/zero > randomfile.bin
  
  ```
  
- Listen ports with `lsof`
  ```shell
  sudo lsof -iTCP -sTCP:LISTEN -P -n
  ```
  
- Discard local git branch changes and replace it with the remote branch
  ``` shell
  # Get into your branch locally  
  git checkout your-branch-name
  
  # Get name of remote branch, usually origin/ prepended to your branch name. 
  git branch -a 
  
  # hard reset 
  git reset --hard origin/your-branch-name
  
  # clean the branch 
  git clean -fd
  
  # check the status 
  git status
  
  ```
  
- Set up cloud instance quickly 
  ```shell
  U="valmikroy"
  export $U
  sudo adduser $U
  sudo passwd $U
  sudo usermod -aG wheel $U  or sudo usermod -aG sudo $U
  sudo sh -c "echo '$U ALL=(ALL) NOPASSWD:ALL'  > /etc/sudoers.d/99-sudo-user"
  
  ```
  
  ```shell
  sudo su -l $U
  mkdir ~/.ssh
  chmod 700 ~/.ssh
  touch ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
  cat >> ~/.ssh/authorized_keys
  ```
  
  
  
  ```shell
  # spit out public key for give key 
   ssh-keygen -y -f id_rsa_${U} > id_rsa_${U}.pub
  ```
  
  
  
- Go setup quick 
```shell
# download go - https://go.dev/doc/install
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz

mkdir -p $HOME/goworkspace

# Add the following in bashrc
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/goworkspace

```
- Docker user permission on Ubuntu
```shell
 sudo usermod -aG docker valmikroy
```





