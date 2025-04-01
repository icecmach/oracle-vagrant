# Vagrant 19c Real Application Clusters (RAC) Build

The Vagrant scripts here will allow you to build a 19c Real Application Clusters (RAC) system by just starting the VMs in the correct order.

This build is based on this [article](https://oracle-base.com/articles/19c/oracle-db-19c-rac-installation-on-oracle-linux-9-using-virtualbox) from oracle-base.

You will also need to download the 19c grid and database software, along with the latest combo patch for grid. This means you must have an Oracle Support account to complete this installation.

## Required Software

* [Grid: LINUX.X64_193000_grid_home.zip](https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html)
* [Database: LINUX.X64_193000_db_home.zip](https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html)
* [Patch 36031453: COMBO OF OJVM RU COMPONENT 19.22.0.0.240116 + GI RU 19.22.0.0.240116](https://support.oracle.com)
* [Patch 6880880: OPatch 19.x](https://updates.oracle.com/download/6880880.html)

## Warning

This installation requires a lot of memory.

It uses at least 17G RAM just for the VMs.

```
dns:   mem_size: 1024
node1: mem_size: 8192
node2: mem_size: 8192
```

## Clone Repository

Pick an area on your file system to act as the base for this git repository and issue the following command. If you are working on Windows, remember to check your Git settings for line terminators. If the bash scripts are converted to Windows terminators you will have problems.

```
git clone https://github.com/icecreammachine/oracle-vagrant.git
```

Copy the Oracle software under the "..../software/" directory. From the "rac" subdirectory, the structure should look like this.

```
➜ tree
.
├── config
│   ├── install.env
│   └── vagrant.yml
├── dns
│   ├── scripts
│   │   ├── dnsmasq-setup.sh
│   │   ├── root_setup.sh
│   │   └── setup.sh
│   └── Vagrantfile
├── node1
│   ├── scripts
│   │   ├── oracle_create_database.sh
│   │   ├── oracle_db_software_installation.sh
│   │   ├── oracle_grid_software_config.sh
│   │   ├── oracle_grid_software_installation.sh
│   │   ├── oracle_user_environment_setup.sh
│   │   ├── root_setup.sh
│   │   └── setup.sh
│   └── Vagrantfile
├── node2
│   ├── scripts
│   │   ├── oracle_user_environment_setup.sh
│   │   ├── root_setup.sh
│   │   └── setup.sh
│   └── Vagrantfile
├── README.md
├── shared_scripts
│   ├── configure_chrony.sh
│   ├── configure_hosts_base.sh
│   ├── configure_hosts_scan.sh
│   ├── configure_shared_disks.sh
│   ├── install_os_packages.sh
│   ├── oracle_software_patch.sh
│   └── prepare_u01_disk.sh
└── software
    ├── LINUX.X64_193000_db_home.zip
    ├── LINUX.X64_193000_grid_home.zip
    ├── p36866740_190000_Linux-x86-64.zip
    ├── p6880880_190000_Linux-x86-64.zip
    └── put_software_here.txt

10 directories, 38 files
```

## Amend File Paths

The "config" directory contains a "install.env" and a "vagrant.yml" file. The combination of these two files contain all the config used for this build. You can alter the configuration of the build here, but remember to make sure the combination of the two stay consistent.

At minimum you will have to amend the following paths in the "vagrant.yml" file, providing suitable paths for the shared disks.

```
asm_crs_disk_1: /u05/VirtualBox/shared/ol9_19_rac/asm_crs_disk_1.vdi
asm_crs_disk_2: /u05/VirtualBox/shared/ol9_19_rac/asm_crs_disk_2.vdi
asm_crs_disk_3: /u05/VirtualBox/shared/ol9_19_rac/asm_crs_disk_3.vdi
asm_crs_disk_size: 2
asm_data_disk_1: /u05/VirtualBox/shared/ol9_19_rac/asm_data_disk_1.vdi
asm_data_disk_size: 40
asm_reco_disk_1: /u05/VirtualBox/shared/ol9_19_rac/asm_reco_disk_1.vdi
asm_reco_disk_size: 20
```

For example, if you were working on a Windows PC, you might create a path called "C:\VirtualBox\shared\ol9_19_rac" and use the following settings.

```
asm_crs_disk_1: C:\VirtualBox\shared\ol9_19_rac\asm_crs_disk_1.vdi
asm_crs_disk_2: C:\VirtualBox\shared\ol9_19_rac\asm_crs_disk_2.vdi
asm_crs_disk_3: C:\VirtualBox\shared\ol9_19_rac\asm_crs_disk_3.vdi
asm_crs_disk_size: 2
asm_data_disk_1: C:\VirtualBox\shared\ol9_19_rac\asm_data_disk_1.vdi
asm_data_disk_size: 40
asm_reco_disk_1: C:\VirtualBox\shared\ol9_19_rac\asm_reco_disk_1.vdi
asm_reco_disk_size: 20
```

If you don't alter them, they will get written to "C:\u05\VirtualBox\shared\ol9_19_rac".

## Build the RAC

The following commands will leave you with a functioning RAC installation.

Start the DNS server.

```
cd dns
vagrant up
```

Start the second node of the cluster. This must be running before you start the first node.

```
cd ../node2
vagrant up
```

Start the first node of the cluster. This will perform all of the installations operations. Depending on the spec of the host system, this could take a long time. It took about 1h10min to complete in my workstation.

```
cd ../node1
vagrant up
```

## Turn Off RAC

Perform the following to turn off the RAC cleanly.

```
cd ../node2
vagrant halt

cd ../node1
vagrant halt

cd dns
vagrant halt
```

## Remove Whole RAC

The following commands will destroy all VMs and the associated files, so you can run the process again.

```
cd ../node2
vagrant destroy -f

cd ../node1
vagrant destroy -f

cd dns
vagrant destroy -f
```

Check all the shared disks have been removed as expected. If they are left behind they will be reused, which will cause problems.

## DHCP Server Issue

If the VirtualBox DHCP server is enabled, you may see something like this.

* DNS up and running.
* Node2 up and running.
* Node1 grid configuration fails with the following error.

```
default: Do grid software-only installation. Wed Nov 18 23:32:46 UTC 2020
default: ******************************************************************************
default: Launching Oracle Grid Infrastructure Setup Wizard...
default: [FATAL] [INS-40718] Single Client Access Name (SCAN):ol7-19-scan could not be resolved.
default:    CAUSE: The name you provided as the SCAN could not be resolved using TCP/IP host name lookup.
default:    ACTION: Provide name to use for the SCAN for which the domain can be resolved.
```

To fix it, disable the VirtualBox DHCP server:

On the GUI, navigate to "File > Host Network Manager > DHCP Server (tab)". Uncheck the "Enable Server" checkbox and click the "Apply" button.

On the terminal execute the command below:

```
vboxmanage list dhcpservers
vboxmanage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
```
