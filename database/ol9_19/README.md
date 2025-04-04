# Oracle 19c on Oracle Linux 9

## Required Software

* [Oracle Database](https://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle19c-linux-5462157.html)
* [Oracle REST Data Services (ORDS)](https://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/)
* [Oracle SQLcl](https://www.oracle.com/tools/downloads/sqlcl-downloads.html)
* [Oracle Application Express (APEX)](https://www.oracle.com/tools/downloads/apex-downloads.html)
* [GraalVM](https://www.graalvm.org/downloads/)
* [Tomcat 9](https://tomcat.apache.org/download-90.cgi)

To patch the installation download the following files:

* [Patch 35742413: COMBO OF OJVM RU COMPONENT 19.21.0.0.231017 + DB RU 19.21.0.0.231017](https://support.oracle.com)
* [Patch 6880880: OPatch 19.x](https://updates.oracle.com/download/6880880.html)

Place the software in the "software" directory before calling the vagrant up command.

Directory contents when software is included.

```
➜ tree
.
├── config
│   ├── install.env
│   └── vagrant.yml
├── README.md
├── scripts
│   ├── 01-setup.sh
│   ├── 02-root_setup.sh
│   ├── 03-prepare_disks.sh
│   ├── 04-install_os_packages.sh
│   ├── 05-oracle_user_environment_setup.sh
│   ├── 06-oracle_software_installation.sh
│   ├── 07-oracle_software_patch.sh
│   ├── 08-oracle_create_database.sh
│   ├── 09-ords_software_installation.sh
│   ├── 10-oracle_service_setup.sh
│   ├── dbora.service
│   ├── server.xml
│   └── web.xml
├── software
│   ├── apache-tomcat-9.0.102.tar.gz
│   ├── apex_24.2_en.zip
│   ├── graalvm-jdk-21_linux-x64_bin.tar.gz
│   ├── LINUX.X64_193000_db_home.zip
│   ├── ords-24.4.0.345.1601.zip
│   ├── p36866623_190000_Linux-x86-64.zip
│   ├── p6880880_190000_Linux-x86-64.zip
│   ├── put_software_here.txt
│   └── sqlcl-24.4.4.086.1931.zip
└── Vagrantfile

4 directories, 26 files
```

To include the patches, set the PATCH_DB variable in the "install.env" file with the value TRUE.

With everything in place, start the build as follows.

```
cd oracle-vagrant/database/ol9_19
➜ vagrant up
```
