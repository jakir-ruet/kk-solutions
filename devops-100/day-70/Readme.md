### Jenkins Security Configuration

#### Step 1: Create User

1. Navigate to: **Manage Jenkins → Users → Create User**
2. Enter the following details:
   - **Username:** `kirsty`
   - **Password:** `8FmzjvFU6S`
   - **Full name:** `Kirsty`

#### Step 2: Install Plugin

- Install the plugin: **Project-based Matrix Authorization Strategy**
  (from **Manage Jenkins → Plugins → Available plugins**).

#### Step 3: Configure Security

1. Navigate to: **Manage Jenkins → Security → Configure Global Security**
2. Under **Authorization**, select:
   - `Project-based Matrix Authorization Strategy`

3. Assign permissions:
   - **Admin user** → ensure `Overall/Administer` is checked.
   - **kirsty** → assign `Overall/Read` only.
   - **Anonymous** → remove all permissions (uncheck any boxes).

4. Click **Save**.

#### Permission

![Permission](/img/matrix-project.png)
