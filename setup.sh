echo -e '\n[*] Running: apt-get install python3-dev python-pip smbclient libssl1.0-dev libxml2-dev zlib1g-dev -y'
						# All of these are for Empire to work. These may not be needed in the future if Empire ever fixes its installer
apt-get install python3-dev python-pip smbclient libssl1.0-dev libxml2-dev zlib1g-dev -y

echo -e '\n[*] Running: pip2 install pipenv pexpect mitm6 ldap3'
pip2 install pipenv mitm6 pexpect ldap3

echo -e '\n[*] Running: git submodule init'
git submodule init

echo -e '\n[*] Running: git submodule update --recursive'
git submodule update --recursive

if [ ! -f submodules/JohnTheRipper/run/john ]; then
	echo -e '\n[*] Running: cd submodules/JohnTheRipper/src && ./configure && make'
	cd submodules/JohnTheRipper/src && ./configure && make
else
	cd submodules/JohnTheRipper/src
fi

echo -e '\n[*] Running: cd ../../impacket/'
cd ../../impacket/

echo -e '\n[*] Running: python2 setup.py install'
python2 setup.py install

echo -e '\n[*] Running: cd ../Empire/setup/'
cd ../Empire/setup/

echo -e '\n[*] Running: yes | ./install.sh'
yes | ./install.sh

echo -e '\n[*] Running: cd ../../../'
cd ../../../

echo -e '\n[*] Running: pipenv install --three'
pipenv install --three

echo -e '\n[*] KALI USERS: run "apt-get remove python-impacket" before running icebreaker'
echo -e '[*] Run "pipenv shell" before running icebreaker'
echo -e '[*] Example usage: ./icebreaker.py -l targets.txt'
