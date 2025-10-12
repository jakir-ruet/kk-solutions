#### Login

- User Name: `admin`
- Password: `Adm!n321`

#### Create a Job

- Item name: `parameterized-job`
- Select `Freestyle project`
- Click `OK`.

#### Configure Parameters

- Check `parameterized-job`.
- Click `Add Parameter`→ select `String Parameter`.
- Name: Stage
- Default Value: Build
- Again, Click `Add Parameter` → select `Choice Parameter`.
- Name: env
- Choices (copy paste):
  - Development
  - Staging
  - Production

#### Add Build Step

- Go `Build` section → Add build step → `Execute shell`.

```bash
echo "Stage parameter is: $Stage"
echo "Environment parameter is: $env"
```

- Hit `Save`.

#### Finally

- Hit `Build with Parameters`

**NB** Build the Jenkins job at least once with choice parameter value `Development` to make sure it passes.
