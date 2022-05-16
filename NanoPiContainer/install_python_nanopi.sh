
apt install libssl-dev

cd ~
git clone https://github.com/madler/zlib.git
cd zlib
./configure --prefix=/usr/local

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc

# exit shell and restart shell

pyenv install 3.8.3
pyenv global 3.8.3
