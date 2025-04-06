. /vagrant_config/install.env

sh /vagrant_scripts/03-prepare_u01_disk.sh
sh /vagrant_scripts/04-install_os_packages.sh
sh /vagrant_scripts/05-configure_hosts_base.sh
sh /vagrant_scripts/06-configure_chrony.sh
sh /vagrant/scripts/configure_hostname.sh

echo "******************************************************************************"
echo "Set root and oracle password and change ownership of /u01." `date`
echo "******************************************************************************"
echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | passwd
echo -e "${ORACLE_PASSWORD}\n${ORACLE_PASSWORD}" | passwd oracle
chown -R oracle:oinstall /u01
chmod -R 775 /u01

su - oracle -c 'sh /vagrant/scripts/oracle_user_environment_setup.sh'
. /home/oracle/scripts/setEnv.sh
su - oracle -c 'sh /vagrant_scripts/oracle_db_software_installation.sh'

echo "******************************************************************************"
echo "Run DB root scripts." `date`
echo "******************************************************************************"
sh ${ORA_INVENTORY}/orainstRoot.sh
sh ${ORACLE_HOME}/root.sh

if [ "${PATCH_DB}" = "true" ]; then
    su - oracle -c 'sh /vagrant_scripts/oracle_software_patch.sh'
fi

su - oracle -c 'sh /vagrant/scripts/oracle_create_database.sh'
