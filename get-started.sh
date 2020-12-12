#!/bin/bash


sudo apt update -y && sudo apt upgrade -y

echo "# Setting PS1"| tee -a ~/.bashrc
echo "export PS1=\"┌──[\[\e[1;31m\] \D{%a %b %d %Y} \t - \u@\h\[\e[1;34m\] \w\[\e[m\] ] \n└──╼ \[\e[44m\]>>>\[\e[m\] \[\e[m\]\"" | tee -a ~/.bashrc

echo "# Sourcing ~/.bash_env"| tee -a ~/.bashrc
echo "[ -f ~/.bash_env ] && source ~/.bash_env"| tee -a ~/.bashrc

echo "# Sourcing ~/.bash_aliases"| tee -a ~/.bashrc
echo "[ -f ~/.bash_aliases ] && source ~/.bash_aliases "| tee -a ~/.bashrc

cat <<EOF > ~/.bash_aliases
alias mv='mv -v '
alias cp='cp -ipv '
alias rm='rm -vrf '
alias mkdir='mkdir -v '
alias python='python3.8'
alias docs='cd /mnt/c/Users/mysub/Documents/'
alias c=clear
alias ll='ls -lrat '
alias ld='ls -ld */'
alias pip='pip3'
alias rsync='rsync -zarvh --progress '
alias activatepy='source ~/git/bin/activate'
EOF

echo "# Setting environ files"
echo "export CONFIG=/home/${USER}/git/src/config/config.properties"| tee -a ~/.bash_env

mkdir /home/${USER}/workspace/{config,workspace} -p

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime

sh ~/.vim_runtime/install_awesome_vimrc.sh
if [ $? -eq 0 ]; then
cat <<EOF > ~/.vim_runtime/my_configs.vim
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

EOF
fi

sudo apt install redis python3-pip nginx curl \
    python3-venv openssh-server ca-certificates tzdata libxml2-utils jq


# sudo reboot


# apt-get -o Acquire::ForceIPv4=true update
# apt-get -o Acquire::ForceIPv4=true upgrade


# /etc/resolv.conf
# nameserver 8.8.8.8

#/etc/wsl.conf
# [network]
# generateResolvConf = false

# https://github.com/microsoft/WSL/issues/5382
