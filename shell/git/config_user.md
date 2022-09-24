

### Git with different users

To configure git repository which has different unix username than your git account name like this one as `valmikroy`. You have to tweak following nobs.

- First, you have to configure you ssh config `~/.ssh/config` for username when called for host `github.com` like following 

```
Host github.com-valmikroy
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_rsa_github
```

- Then you have to update global git config `~/.gitconfig` as following

```
[user]
        name = valmikroy
        email = myemail@gmail.com
```

- Then make sure you setup desired git repository to be managed over ssh instead of http inside `.git/config` of repo

```
[remote "origin"]
        url = git@github.com:valmikroy/code_snips.git
```
- How to get signature of the key to idetify which keys are installed in github ?
```
ssh-keygen -l -E md5 -f ~/.ssh/id_rsa_github
```
