#### Login

- User Name: `admin`
- Password: `Adm!n321`

#### Create a New Job

- Click `New Item` name `devops-test-job`, select `Freestyle project`.
- Hit `Ok`

#### Configure the Job

- Go `Add build step` select `Execute shell`
- Paste `echo "hello world!!"`.
- Hit `Apply` & `Save`

#### Create a View Named `devops-crons`

- Go `Dashboard` > `admin` > `My Views` > `All`
- Hit `+` button give name `devops-crons`, select `List View` & hit `Create`

#### Add Jobs to the View

- `Dashboard` > `admin` > `My Views` > `devops-crons` > `Edit View`
- Check `devops-cron-job` & `devops-test-job`
- Hit `Apply` & `Save`

#### Confirm Periodic Builds

- `Dashboard` > `devops-test-job` > `Configuration`
- Go `Triggers` & section `Build periodically`
- Paste `* * * * *`
- Hit `Apply` & `Save`
- Not need to Hit `Build Now`

##### It's automatically build in each minute
