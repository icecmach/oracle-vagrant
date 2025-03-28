echo "******************************************************************************"
echo "Prepare yum repos and install base packages." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

dnf install -y -q dnf-utils expect openssl parted tree unzip zip

echo "******************************************************************************"
echo "Add extra OS packages. Most should be present." `date`
echo "******************************************************************************"
dnf install -y -q bc
dnf install -y -q binutils
dnf install -y -q compat-openssl11
dnf install -y -q elfutils-libelf
dnf install -y -q glibc
dnf install -y -q glibc-devel
dnf install -y -q ksh
dnf install -y -q libaio
dnf install -y -q libXrender
dnf install -y -q libX11
dnf install -y -q libXau
dnf install -y -q libXi
dnf install -y -q libXtst
dnf install -y -q libgcc
dnf install -y -q libnsl
dnf install -y -q libstdc++
dnf install -y -q libxcb
dnf install -y -q libibverbs
dnf install -y -q make
dnf install -y -q policycoreutils
dnf install -y -q policycoreutils-python-utils
dnf install -y -q unixODBC
dnf install -y -q smartmontools
dnf install -y -q sysstat
dnf install -y -q chrony
dnf install -y -q net-tools # Clusterware
dnf install -y -q nfs-utils # ACFS
dnf install -y -q python # ACFS
dnf install -y -q python-configshell # ACFS
dnf install -y -q python-rtslib # ACFS
dnf install -y -q python-six # ACFS
dnf install -y -q targetcli # ACFS
dnf install -y -q sshpass
dnf install -y -q libxcrypt-compat

echo "******************************************************************************"
echo "Firewall." `date`
echo "******************************************************************************"
systemctl stop firewalld
systemctl disable firewalld


echo "******************************************************************************"
echo "SELinux." `date`
echo "******************************************************************************"
sed -i -e "s|SELINUX=enforcing|SELINUX=permissive|g" /etc/selinux/config
setenforce permissive
