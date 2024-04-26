Bash snips



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
  
- 

