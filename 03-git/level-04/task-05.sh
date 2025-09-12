
# Git Level 4: Git Setup from Scratch

ssh natasha@ststor01
Bl@kW
sudo su

yum install git -y
git config --global --add user.name natasha
git config --global --add user.email natasha@stratos.xfusioncorp.com

git init --bare /opt/games.git
cp /tmp/update /opt/games.git/hooks/
cd /usr/src/kodekloudrepos/
git clone /opt/games.git


cd /usr/src/kodekloudrepos/games
git checkout -b xfusioncorp_games

cp /tmp/readme.md .
git add readme.md
git commit -m "Readme file"
git push origin xfusioncorp_games

git checkout -b master
git branch
git push origin master # Error expected
