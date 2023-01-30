#!/bin/sh

# To ensure the GraphQL docs load in the explorer, set the _APP_OPTIONS_ABUSE
# variable to disabled in your .env file.
# 
# If you have a domain, run this script passing the endpoint like:
#   ./start-appwrite-graphql-explorer.sh https://appwrite.example.com/v1
#
# After you see "GraphQL Explorer listening on port 3000!", open your browser
# and browse to http://localhost:3000/

APPWRITE_ENDPOINT=http://localhost/v1
if [ ! -z "$1" ]; then
    APPWRITE_ENDPOINT=$1
fi

docker run --rm -p "3000:3000" -e "SERVER_URL=$APPWRITE_ENDPOINT/graphql" appwrite/altair:0.3.0