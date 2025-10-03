#### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `Matrix Authorization Strategy` > Hit `Install` Button.
- Restart

#### Enable Security & Inheritance

- Go to `Manage Jenkins` > Configure Global Security.
- Go `Authorization`
- Add user name `sam` and `rohan`
- Give permission to `sam` > `Build`, `Configure` & `Read`
- Give Permission to `rohan` > `Build`, `Cancel`, `Configure`, `Read`, `Update` & `Tag`
- Hit `Apply` & `Ok`

#### Enable Inheritance

- Check `Project-based security`
- Select `Inherit permissions from parent ACL`
- Add user name `sam` and `rohan`
- Give permission to `sam` > `Build`, `Configure` & `Read`
- Give Permission to `rohan` > `Build`, `Cancel`, `Configure`, `Read`, `Update` & `Tag`
- Hit `Apply` & `Ok`

#### Build Now
