# Oracle 19c Data Guard Build

The Vagrant scripts here will allow you to build a 19c Data Guard system by just starting the VMs in the correct order.

If you need a more detailed description of this build, check out the article here.

- [Data Guard Physical Standby Setup Using the Data Guard Broker in Oracle Database 19c](https://oracle-base.com/articles/19c/data-guard-setup-using-broker-19c)

## Required Software

- [Database LINUX.X64_193000_db_home.zip](https://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle19c-linux-5462157.html)

## Clone Repository

On Windows, remember to check git settings for line terminators. If the bash scripts are converted to Windows terminators it will cause problems.

```bash
git clone https://github.com/icecmach/oracle-vagrant.git
```

Copy the Oracle software under the "dataguard/software" directory. From the "dataguard" subdirectory, the structure should look like this.

```bash
➜ tree
.
├── config
│   ├── install.env
│   └── vagrant.yml
├── node1
│   ├── scripts
│   │   ├── oracle_create_database.sh
│   │   ├── oracle_user_environment_setup.sh
│   │   ├── root_setup.sh
│   │   └── setup.sh
│   └── Vagrantfile
├── node2
│   ├── scripts
│   │   ├── oracle_create_database.sh
│   │   ├── oracle_user_environment_setup.sh
│   │   ├── root_setup.sh
│   │   └── setup.sh
│   └── Vagrantfile
├── README.md
├── shared_scripts
│   ├── configure_chrony.sh
│   ├── configure_hostname.sh
│   ├── configure_hosts_base.sh
│   ├── install_os_packages.sh
│   ├── oracle_db_software_installation.sh
│   ├── oracle_software_patch.sh
│   └── prepare_u01_disk.sh
└── software
    └── put_software_here.txt

8 directories, 21 files
```

The patch files in the "software" directory are optional. By detault the patch script is commented out from the node-specific "root_setup.sh" scripts.

## Build the Data Guard System

The following commands will leave you with a functioning Data Guard installation.

Start the first node and wait for it to complete. This will create the primary database.

```bash
cd node1
vagrant up
```

Start the second node and wait for it to complete. This will create the standby database and configure the broker.

```bash
cd ../node2
vagrant up
```

## Turn Off System

Perform the following to turn off the system cleanly.

```bash
cd ../node2
vagrant halt

cd ../node1
vagrant halt
```

## Remove Whole System

The following commands will destroy all VMs and the associated files, so you can run the process again.

```bash
cd ../node2
vagrant destroy -f

cd ../node1
vagrant destroy -f
```
