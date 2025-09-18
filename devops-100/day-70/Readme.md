- **Step 1:** Create User
  - Click Users → Create User.
  - Username: kirsty
  - Password: 8FmzjvFU6S
  - Full name: Kirsty

- Install `Project-based Matrix Authorization`

- **Step 2:** Configure Security
  - Click Security → Configure Global Security.
  - Under Authorization, select `Project-based Matrix Authorization Strategy`.
  - Assign permissions:
  - Admin user: ensure Overall/Administer is checked.
  - kirsty: Overall/Read only.
  - Anonymous: remove all permissions (uncheck any boxes).
  - Click Save.

![Permission](/img/matrix-project.png)
