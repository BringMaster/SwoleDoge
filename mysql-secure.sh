#!/bin/bash

[ ! -e /usr/bin/expect ] && apt-get update && apt-get -y install expect
PASS_MYSQL_ROOT=`openssl rand -base64 12` # Save this password

# Set password with `debconf-set-selections` You don't have to enter it in prompt
debconf-set-selections <<< "mysql-server mysql-server/root_password password ${PASS_MYSQL_ROOT}" # new password for the MySQL root user
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${PASS_MYSQL_ROOT}" # repeat password for the MySQL root user

# Other Code.....
mysql --user=root --password=${PASS_MYSQL_ROOT} << EOFMYSQLSECURE
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOFMYSQLSECURE

# Note down this password. Else you will lose it and you may have to reset the admin password in mySQL
echo -e "SUCCESS! MySQL password is: ${PASS_MYSQL_ROOT}"
