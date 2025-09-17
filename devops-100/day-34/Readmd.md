```bash
ssh natasha@ststor01
cd /opt/cluster.git/hooks
cp post-update.sample post-update
```

```bash
chmod +x post-update
```

```bash
cd /usr/src/kodekloudrepos/cluster
git checkout master
git merge --no-ff feature -m "Merge feature into master"
git push origin master
git fetch --tags
git tag
git show release-$(date +%F)
```

```bash
# optional
touch trigger_hook.txt
git add trigger_hook.txt
git commit -m "Trigger post-update hook"
git push origin master
```
