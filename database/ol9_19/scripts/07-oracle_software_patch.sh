. /vagrant/config/install.env

# This patch script should only be used for a clean installation.
# It doesn't patch existing databases.
echo "******************************************************************************"
echo "Patch Oracle Software." `date`
echo "******************************************************************************"

# Doc ID 2002334.1
export PERL5LIB=$ORACLE_HOME/perl/lib
export PATH=${ORACLE_HOME}/bin:$PATH
export PATH=$ORACLE_HOME/perl/bin:${PATH}:${ORACLE_HOME}/OPatch

echo "******************************************************************************"
echo "Apply patches." `date`
echo "******************************************************************************"

cd ${PATCH_PATH2}
opatch prereq CheckConflictAgainstOHWithDetail -ph ./
opatch apply -silent
