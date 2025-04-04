. /vagrant/config/install.env

sh /vagrant/scripts/03-prepare_disks.sh
sh /vagrant/scripts/04-install_os_packages.sh

mkdir -p ${SCRIPTS_DIR}
mkdir -p ${SOFTWARE_DIR}
mkdir -p ${DATA_DIR}
chown -R oracle.oinstall ${SCRIPTS_DIR} /u01 /u02

echo "******************************************************************************"
echo "Prepare environment and install the software." `date`
echo "******************************************************************************"
su - oracle -c 'sh /vagrant/scripts/05-oracle_user_environment_setup.sh'
su - oracle -c 'sh /vagrant/scripts/06-oracle_software_installation.sh'

echo "******************************************************************************"
echo "Run root scripts." `date`
echo "******************************************************************************"
sh ${ORA_INVENTORY}/orainstRoot.sh
sh ${ORACLE_HOME}/root.sh

if [ "${PATCH_DB}" = "true" ]; then
  su - oracle -c 'sh /vagrant/scripts/07-oracle_software_patch.sh'
fi

echo "******************************************************************************"
echo "Create the database and install the ORDS software." `date`
echo "******************************************************************************"
su - oracle -c 'sh /vagrant/scripts/08-oracle_create_database.sh'
su - oracle -c 'sh /vagrant/scripts/09-ords_software_installation.sh'

sh /vagrant/scripts/10-oracle_service_setup.sh
