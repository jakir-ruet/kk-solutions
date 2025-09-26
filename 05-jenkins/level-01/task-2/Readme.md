### Jenkins Setup – Install Git and GitLab Plugins

#### Step 1: Access Jenkins

- Click the **Jenkins button** on the lab’s top bar.
- Login with the following credentials:
  - **Username:** `admin`
  - **Password:** `Adm!n321`

#### Step 2: Install Git and GitLab Plugins

1. From the Jenkins dashboard, navigate to:
   **Manage Jenkins → Plugins → Available plugins**
2. Search for and select the following plugins:
   - `Git plugin`
   - `GitLab plugin`
3. Click **Install without restart**.

#### Step 3: Restart Jenkins (if required)

- After installation, Jenkins may show the option:
  **“Restart Jenkins when installation is complete and no jobs are running”**
- ✅ Select this option.
- Jenkins will shut down, install plugins, and restart automatically.

#### Step 4: Wait for Jenkins to Restart

- Wait for the login page to reappear at `https://8080-port-pe533mpvdd7fvfar.labs.kodekloud.com/`.
- Login again with:
  - **Username:** `admin`
  - **Password:** `Adm!n321`

#### ✅ Final Check

- Both **Git** and **GitLab** plugins should now be available in Jenkins.
- Verify under: **Manage Jenkins → Plugins → Installed plugins**.
