# Oracle Linux 9

A simple Vagrant build for Oracle Linux 9.

```
➜ tree
.
├── config
│   └── vagrant.yml
├── README.md
├── scripts
│   ├── prepare_disks.sh
│   └── setup.sh
├── software
│   └── put_software_here.txt
└── Vagrantfile

4 directories, 6 files
```

With everything in place, you can initiate the build as follows.

```
cd oracle-vagrant\linux\ol9_clean\
vagrant up
```
