. /vagrant_config/install.env

NODE_FQ_HOSTNAME=$1

echo "******************************************************************************"
echo "Create environment scripts." `date`
echo "******************************************************************************"
mkdir -p /home/oracle/scripts

cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=${NODE_FQ_HOSTNAME}
export ORACLE_BASE=${ORACLE_BASE}
export ORA_INVENTORY=${ORA_INVENTORY}
export ORACLE_HOME=\$ORACLE_BASE/${ORACLE_HOME_EXT}
export ORACLE_SID=${ORACLE_SID}
export DATA_DIR=${DATA_DIR}
export ORACLE_TERM=xterm
export BASE_PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$BASE_PATH

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib

alias sdba='sqlplus / as sysdba'
alias sq='sql / as sysdba'
alias rmant='rman target /'
alias pora='ps -ef | grep pmon'
alias orab='cd $ORACLE_BASE'
alias orah='cd $ORACLE_HOME'
alias orad='cd $DATA_DIR'
alias scd='cd /home/oracle/scripts'
alias ctns='cd $ORACLE_HOME/network/admin'
alias la='ls -lAh'
alias ll='ls -lh'
alias envs='env | sort'
EOF

cat >> /home/oracle/.bash_profile <<EOF
. /home/oracle/scripts/setEnv.sh
EOF

echo "******************************************************************************"
echo "Create directories." `date`
echo "******************************************************************************"
. /home/oracle/scripts/setEnv.sh
mkdir -p ${ORACLE_HOME}
mkdir -p ${DATA_DIR}
