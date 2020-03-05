export rvm_ignore_gemrc_issues=1
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s  --  --auto-dotfiles
source  /home/users/abhsawan/.profile
rvm install ruby
rvm --default use ruby
gem install bundle


#rvm get stable --auto-dotfiles
