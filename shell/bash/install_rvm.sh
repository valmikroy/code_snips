export rvm_ignore_gemrc_issues=1
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash
source  /home/users/abhsawan/.profile
rvm install 2.4.0
rvm use 2.4.0 --default
gem install bundle


#rvm get stable --auto-dotfiles
