# raspalt
Utility Salt States for Raspbian

## Purpose

The salt states provided by the repository are a collection of configuration steps which might be helpful when configuring your Linux system. The states are mainly written to work on Raspbian but may work on any Debian based distribution.

## Initial setup and deployment

It's the nature of salt states that they require to be executed by [SaltStack salt](https://github.com/saltstack/salt). It itself needs to be installed. There are various ways to do that, instructions and details can be found in the [Salt Package Repo](https://repo.saltstack.com). Salt requires one master process on one host and one minion process on multiple hosts. The minions are controlled by the master. 

For Raspian and our purposes a quick start to bring the salt master online, is

```bash
#!/bin/bash
wget -O - https://repo.saltstack.com/apt/debian/9/armhf/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo echo 'deb http://repo.saltstack.com/apt/debian/9/armhf/latest stretch main' > /etc/apt/sources.list.d/saltstack.list
sudo apt-get update
sudo apt-get install 'salt-master'

```

For each minion the procedure is very similar

```bash
#!/bin/bash
wget -O - https://repo.saltstack.com/apt/debian/9/armhf/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo echo 'deb http://repo.saltstack.com/apt/debian/9/armhf/latest stretch main' > /etc/apt/sources.list.d/saltstack.list
sudo apt-get update
sudo apt-get install 'salt-minion'

```

Now it's time to invoke our repository

```bash
#!/bin/bash
mkdir -p ~/raspalt && cd ~/raspalt
git clone https://github.com/saltstack/raspalt
sudo cp -r 'raspalt/etc/salt/*' /etc/salt/
if service --status-all | grep -Fq 'salt-master'; then
  sudo service 'salt-master' restart
fi
if service --status-all | grep -Fq 'salt-minion'; then
  sudo service 'salt-minion' restart
fi
cd ~ && rm -rf ~/raspalt
```

This basically copied the needed salt-master and salt-minion configuration. The fun fact with that is that the salt states which define the configuration steps are directly fetched from github. There is no need to maintain them locally.

## Feature set

This is by nature work in progress. What currently is available is

* [log2ram](./states/log2ram/README.md)
* [timesync](./states/timesyncd/README.md)
