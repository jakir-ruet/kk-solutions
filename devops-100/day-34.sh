ssh natasha@ststor01
Bl@kW
sudo su

cd /opt/apps.git/hooks

sudo chown -R natasha:natasha /opt/apps.git
sudo chown -R natasha:natasha /usr/src/kodekloudrepos/apps

sudo vi post-update

#!/bin/bash
date=$(date +'%Y-%m-%d') # Get current date in YYYY-MM-DD format
git --git-dir=/opt/apps.git tag "release-$date" master # Create a release tag with current date
sudo chmod +x post-update

cd /usr/src/kodekloudrepos/apps
git branch
git checkout master
git merge feature
git push

cd /opt/apps.git
git tag

release-2025-09-06 # Should See


 - required data not found under repo, seems like 'feature' branch was not merged into the 'master' branch
