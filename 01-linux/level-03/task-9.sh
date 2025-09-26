#!/bin/bash

# Step 1: Install Apache and mod_authnz_pam
sudo yum install -y httpd mod_authnz_pam
http -M | grep pam
authnz_pam_module (shared) # should show, if not show then use step 2.

# Step 2: Ensure the module is loaded
sudo bash -c 'cat > /etc/httpd/conf.modules.d/10-authnz_pam.conf << EOF
LoadModule authnz_pam_module modules/mod_authnz_pam.so
EOF'

authnz_pam_module (shared) # Now should show

# Step 3: Create Apache protected directory config
sudo bash -c 'cat > /etc/httpd/conf.d/authnz_pam.conf << EOF
<Directory "/var/www/html/protected">
    AuthType Basic
    AuthName "PAM Authentication"
    AuthBasicProvider PAM
    AuthPAMService httpd-auth
    Require valid-user
</Directory>
EOF'

# Step 4: Create PAM service file for Apache
sudo bash -c 'cat > /etc/pam.d/httpd-auth << EOF
auth    required  pam_listfile.so item=user sense=deny file=/etc/httpd/conf.d/denyusers onerr=succeed
auth    include   system-auth
account include   system-auth
EOF'

# Step 5: Set permissions for /etc/shadow
sudo chgrp apache /etc/shadow
sudo chmod 440 /etc/shadow

# Step 6: Restart Apache
sudo apachectl configtest
sudo systemctl restart httpd

# Step 6: Test
echo "curl -u kirsty:B42NgHA7Ya http://localhost:8080/protected/"

# should show
# This is KodeKloud Protected Directory
