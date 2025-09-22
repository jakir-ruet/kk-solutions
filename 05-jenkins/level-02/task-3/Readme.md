### Login

#### Jenkins Server

- User Name: `admin`
- Password: `Adm!n321`

#### Gitea

- User Name: `sarah`
- Password: `Sarah_pass123`

#### Install Required Plugins in Jenkins

- Go to `Jenkins Dashboard` > `Manage Jenkins` > `Manage Plugins` > `Available Tab`
- Update all plugin
- Install `Git`, `Git Client`, `Parameterized Build`, `Matrix Authorization Strategy` plugins
- Restart

#### Add Gitea Credentials to Jenkins

- Go to Jenkins `Dashboard` >` Manage Jenkins` > `Manage Credentials` > `(Global) > Add Credentials`.
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `gitea-credentials`
- Description: `Skip`
- Click `Save`.

#### Create the Jenkins Job `web_app`

- Go to Jenkins `Dashboard` > `New Item`.
- Name the job `web_app` and select `Freestyle` project,
- Then click `OK`.
- Configure the Job
  - General Tab
  - Select `This project is parameterized`
  - Click `Add Parameter` and choose `Choice Parameter`.
  - Name the parameter: `Branch`
  - In Choices, add the following branches:
    - version1
    - version2
    - version3

#### Source Code Management

- Select Git.
- In the `Repository URL` field, enter:
- `http://git.stratos.xfusioncorp.com/sarah/web_app.git`
- Credentials: `gitea-credentials`
- Branches to build: `${Branch}`

#### Advanced Project Options (Configure Custom Workspace)

- Scroll down to` Advanced Project` Options and enable `Use custom workspace`
- Set the Workspace path to `/var/lib/jenkins/${Branch}`

#### Build Section `Deploy to Stratos DC`

- Click `Add build` step and choose `Execute shell`.

```bash
#!/bin/bash
cd /var/lib/jenkins/${Branch}
rm -rf /var/www/html/*
cp -r ./* /var/www/html/
```

#### Configure Security (Optional but Recommended)

- Go to Jenkins `Dashboard` > `Manage Jenkins` > `Configure Global Security`.
- Under `Authorization`, select `Project-based Matrix Authorization Strategy`.
- Assign permissions:
  - Admin user: Ensure `Overall/Administer` is checked.
  - Sarah (your user): Assign `Overall/Read` permission.
  - Anonymous: Uncheck `all permissions` to restrict access.
- Click `Save`.

#### Build & Run the Job
