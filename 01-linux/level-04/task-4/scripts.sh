ssh peter@stdb01
Sp!dy

sudo vi /opt/scripts/database.sh
Sp!dy

#!/bin/bash

DB_NAME="kodekloud_db01"
DB_USER="kodekloud_roy"
DB_PASS="asdfgdsd"

# Check if database exists
if mysql -u root -e "USE $DB_NAME" 2>/dev/null; then
    echo "Database already exists"
else
    mysql -u root -e "CREATE DATABASE $DB_NAME;"
    echo "Database $DB_NAME has been created"

    mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
fi

# Check if database has tables
if mysql -u root $DB_NAME -e "SHOW TABLES;" | grep -q "."; then
    echo "database is not empty"
else
    mysql -u root $DB_NAME < /opt/db_backups/db.sql
    echo "imported database dump into $DB_NAME database"
fi

# Take backup
mysqldump -u root $DB_NAME > /opt/db_backups/$DB_NAME.sql

sudo chmod +x /opt/scripts/database.sh
sudo /opt/scripts/database.sh
ls -la /opt/db_backups/
