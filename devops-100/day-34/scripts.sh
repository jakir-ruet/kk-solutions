#!/bin/sh
DATE=$(date +%F)
CHANGED_MASTER=0
for ref in "$@"
do
    if echo "$ref" | grep -q "refs/heads/master"; then
        CHANGED_MASTER=1
        break
    fi
done
if [ $CHANGED_MASTER -eq 1 ] || [ -z "$@" ]; then
    echo "Creating release tag for $DATE..."
    if ! git rev-parse "release-$DATE" >/dev/null 2>&1; then
        git tag -a "release-$DATE" -m "Release for $DATE"
    else
        echo "Tag release-$DATE already exists"
    fi
fi
