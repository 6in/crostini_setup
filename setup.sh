sudo apt update -y && sudo apt upgrade -y

# VS-Code
if [ ! -e "./vscode.dev" ] ; then
  curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode.deb
fi
sudo apt install -y ./vscode.deb

# japanese-fonts
if [ ! -e "./2.011R.tar.gz" ] ; then
  curl -OL https://github.com/adobe-fonts/source-han-code-jp/archive/2.011R.tar.gz
fi

tar zxf 2.011R.tar.gz
sudo cp ./source-han-code-jp-2.011R/OTF/* /usr/local/share/fonts
sudo fc-cache -fv

# Install MOZC
sudo apt install -y fcitx-mozc tmux htop terminator build-essential  

echo "fcitx > /dev/null 2>&1" >> ~/.bashrc
echo "/usr/bin/fcitx-autostart" >> ~/.bashrc

sudo sh setup_root.sh $HOME

fcitx-configtool

# for japanese locale
sudo dpkg-reconfigure tzdata
sudo timedatectl set-timezone Asia/Tokyo
sudo apt -y install task-japanese locales-all fonts-ipafont
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

# for python
sudo apt install libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
echo export PYENV_VIRTUALENV_DISABLE_PROMPT=1 >> ~/.bashrc
source ~/.bashrc
# install python
pyenv install 3.7.5
pyenv global 3.7.5

# for nim
sudo apt install -y gdb
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
echo 'export PATH=~/.nimble/bin:$PATH' >> ~/.bashrc

# for nodejs
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" ' >> ~/.bashrc 
source ~/.bashrc
nvm install v12.13.0

# SDKMAN
sudo apt install -y zip unzip
curl -s "https://get.sdkman.io" | bash
source ~/.bashrc
sdk install java 11.0.4.hs-adpt
sdk install maven
sdk install gradle
sdk install groovy
sdk install kotlin
sdk install grails

# VS-Code install extensions
code --install-extension kosz78.nim
code --install-extension ms-ceintl.vscode-language-pack-ja
code --install-extension webfreak.debug
code --install-extension ms-python.python

# neovim 事前準備
sudo apt install -y fuse libfuse-dev
echo 'export XDG_CONFIG_HOME=~/.config' >> ~/.bashrc
source ~/.bashrc
cp ./nvim $XDG_CONFIG_HOME/nvim
