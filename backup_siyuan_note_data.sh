#!/bin/sh
echo "================START==================="
from=siyuan_note
to=siyuan_show
token=jbwahhblvd51uzci
port=8803
docker stop $from
docker stop $to
pp=/home/docker/
ps=/data/
echo rm -rf $pp$to$ps
rm -rf $pp$to$ps
echo cp -Rf $pp$from$ps $pp$to
cp -Rf $pp$from$ps $pp$to
docker start $from
docker start $to

echo curl -H "Authorization: Token $token" -X POST -d "{}" http://localhost:$port/api/filetree/refreshFiletree
curl -H "Authorization: Token $token" -X POST -d "{}" http://localhost:$port/api/filetree/refreshFiletree

echo ""
echo "================DONE==================="


