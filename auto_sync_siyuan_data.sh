#! /bin/bash
token="l6kez3cwhcouw8j5"
url="http://120.24.175.31:8890/api/sync/performSync"
curl -H "Authorization: Token $token" -X POST -d {} $url
