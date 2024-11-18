# Oracle Linux 9

A simple Vagrant build for Oracle Linux 9.

## Required Software

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

```
$ tree
.
+--- config
|   +--- install.env
|   +--- vagrant.yml
+--- README.md
+--- scripts
|   +--- prepare_disks.sh
|   +--- setup.sh
+--- software
|   +--- put_software_here.txt
+--- Vagrantfile
$
```

With everything in place, you can initiate the build as follows.

```
cd oracle-vagrant\database\ol9_clean\
vagrant up
```
