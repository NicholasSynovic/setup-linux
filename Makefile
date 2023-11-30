CORE_PACKAGES = gcc make perl git curl ca-certificates gnupg

updateSystem:
	apt update
	apt upgrade -y
	apt autoremove --purge -y
	snap refresh

installCoreSoftware:
	apt install -y $(CORE_PACKAGES)

installAnsible:
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	/usr/bin/python3 get-pip.py --user
	rm get-pip.py
	/usr/bin/python3 -m pip install --upgrade pip
	/usr/bin/python3 -m pip install --user ansible
	/usr/bin/python3 -m ansible galaxy collection install community.general --force

runAnsible:
	/usr/bin/python3 -m ansible playbook minimalConfiguration.yml
