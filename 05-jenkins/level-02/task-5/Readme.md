### Install Required Plugins in Jenkins

- Go to `Jenkins Dashboard` > `Manage Jenkins` > `Manage Plugins` > `Available Tab`
- Update all plugin
- Restart

### Create New Jenkins Job

- Click `New Item` in the left menu.
- Item name: `copy-logs`
- Type: `Freestyle project`
- Click `OK`.
- Configure Build Triggers
- Check `Build periodically`

```bash
*/10 * * * *
```

```bash
#!/bin/bash
# Define server credentials and paths
APP_SERVER="tony@stapp01.stratos.xfusioncorp.com"
APP_PASS="Ir0nM@n"
STORAGE_SERVER="natasha@ststor01.stratos.xfusioncorp.com"
STORAGE_PASS="Bl@kW"
TMP_DIR="/tmp/apache_logs"
DEST_DIR="/usr/src/security"
# Create temp dir
mkdir -p ${TMP_DIR}
# Copy logs from App Server to Jenkins workspace
sshpass -p "${APP_PASS}" scp -o StrictHostKeyChecking=no ${APP_SERVER}:/var/log/httpd/access_log ${TMP_DIR}/
sshpass -p "${APP_PASS}" scp -o StrictHostKeyChecking=no ${APP_SERVER}:/var/log/httpd/error_log ${TMP_DIR}/
# Send them to storage server
sshpass -p "${STORAGE_PASS}" scp -o StrictHostKeyChecking=no ${TMP_DIR}/* ${STORAGE_SERVER}:${DEST_DIR}/
# Clean up
rm -rf ${TMP_DIR}
```

### Save the Job

Click `Apply` and `Save`.

### `ssh natasha@ststor01.stratos.xfusioncorp.com` # Password: Bl@kW

```bash
ls -l /usr/src/security/
```

### Should see

```bash
access_log                                  100%   10KB   10.0KB/s   00:01
error_log                                   100%    5KB    5.0KB/s   00:01
```
