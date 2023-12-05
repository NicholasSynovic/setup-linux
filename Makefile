CORE_PACKAGES = gcc make perl git curl ca-certificates gnupg snapd

installAnsible:
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	/usr/bin/python3 get-pip.py --user
	rm get-pip.py
	/usr/bin/python3 -m pip install --upgrade pip
	/usr/bin/python3 -m pip install --user ansible
	/usr/bin/python3 -m ansible galaxy collection install community.general --force

installCoreSoftware:
	sudo apt install -y $(CORE_PACKAGES)

updateSystem:
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoremove --purge -y
	sudo snap refresh

runAnsible:
	python3 -m ansible playbook minimalConfiguration.yml
	python3 -m ansible playbook installAPTSoftware.yml --ask-become-pass
	python3 -m ansible playbook installLinuxbrewSoftware.yml --ask-become-pass
#	python3 -m ansible playbook buildSoftware.yml
