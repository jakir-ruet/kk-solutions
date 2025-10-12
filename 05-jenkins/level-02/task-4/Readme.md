### Install Required Plugins in Jenkins

- Go to `Jenkins Dashboard` > `Manage Jenkins` > `Manage Plugins` > `Available Tab`
- Update all plugin
- Install `SSH` & `Publish over SSH` plugins
- Restart

```bash
ssh jenkins@jenkins.stratos.xfusioncorp.com # Password: j@rv!s
sshpass -V # check it should available
```

### Create the Jenkins Job `database-backup`

- Go to Jenkins `Dashboard` > `New Item`.
- Name the job `database-backup` and select `Freestyle` project,
- Then click `OK`.
- `Add build step` > `Execute shell`

```bash
#!/bin/bash
# Define variables
DATE=$(date +%F)
DUMP_FILE="db_${DATE}.sql"
# Step 1: SSH to DB server and create dump
sshpass -p 'Sp!dy' ssh -o StrictHostKeyChecking=no peter@stdb01.stratos.xfusioncorp.com \
"mysqldump -u kodekloud_roy -pasdfgdsd kodekloud_db01 > /tmp/${DUMP_FILE}"
# Step 2: Copy dump to Jenkins server
sshpass -p 'Sp!dy' scp -o StrictHostKeyChecking=no peter@stdb01.stratos.xfusioncorp.com:/tmp/${DUMP_FILE} /tmp/
# Step 3: Copy dump from Jenkins to Backup Server
sshpass -p 'H@wk3y3' scp -o StrictHostKeyChecking=no /tmp/${DUMP_FILE} clint@stbkp01.stratos.xfusioncorp.com:/home/clint/db_backups/
# Step 4: Clean up temporary file on Jenkins
rm -f /tmp/${DUMP_FILE}
```

- Schedule the Job
  - Build `Triggers`
  - `Build periodically`

```bash
*/10 * * * *
```

### Save the Job

- Click `Save` at the `bottom`.

### Verify the Backup

```bash
ssh clint@stbkp01.stratos.xfusioncorp.com # Password: H@wk3y3
ls -l /home/clint/db_backups/
```

```bash
You should see a file like `db_2025-10-11.sql`
```
