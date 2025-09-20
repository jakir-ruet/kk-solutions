### Jenkins Task: Create Folder and Move Jobs

#### Step 1: Log in to Jenkins

1. Open the Jenkins UI (dashboard).
2. Click the **Jenkins** button in the top bar if needed.
3. Log in using the credentials:
   - **Username:** `admin`
   - **Password:** `Adm!n321`

#### Step 2: Install Required Plugins

1. Navigate to **Manage Jenkins → Plugins → Available plugins**.
2. Search for and install:
   - **Folders Plugin**
3. After installation, select:
   - **Restart Jenkins when installation is complete and no jobs are running**
4. Jenkins may become unresponsive temporarily. Refresh the page if needed.

#### Step 3: Create Folder Named `Apache`

1. On the Jenkins dashboard, click **New Item** (or **+ New Item**).
2. Enter the folder name: **Apache**.
3. Select **Folder**.
4. Click **OK**.
5. (Optional) Add a description.
6. Click **Save**.

#### Step 4: Move Existing Jobs to Folder

1. From the Jenkins dashboard, locate the job **httpd-php**.
2. Click the dropdown (arrow) next to the job → **Move**.
3. Select **Apache** as the destination folder.
4. Repeat steps 1–3 for the job **services**.
5. Verify both jobs are now under the **Apache** folder.

#### Step 5: Verification

- Confirm the Jenkins dashboard now shows:
  - A folder named **Apache**.
  - Inside it: **httpd-php** and **services** jobs.

#### Deliverables (Documentation)

Capture **screenshots** or record a **Loom video** for review:

1. Jenkins dashboard after login.
2. Installed plugins page (showing **Folders plugin** installed).
3. Newly created **Apache** folder.
4. Apache folder containing the **httpd-php** and **services** jobs.
