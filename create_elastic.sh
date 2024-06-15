#!/bin/bash

read -p "Enter Elasticsearch URL (e.g., http://localhost): " es_url
read -p "Enter Elasticsearch port (e.g., 9200): " es_port

read -p "Do you want to create an index or a user? (index/user): " action

if [ "$action" == "index" ]; then
    read -p "Enter index name: " index_name

    index_body=$(cat <<EOF
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1
  },
  "mappings": {
    "properties": {
      "field1": {
        "type": "text"
      },
      "field2": {
        "type": "keyword"
      }
    }
  }
}
EOF
)

    curl -X PUT "$es_url:$es_port/$index_name" -H 'Content-Type: application/json' -d"$index_body"
    echo "Index '$index_name' created successfully."

elif [ "$action" == "user" ]; then
    read -p "Enter username: " username
    read -s -p "Enter password: " password
    echo
    read -p "Enter full name: " full_name
    read -p "Enter email: " email

    user_body=$(cat <<EOF
{
  "password": "$password",
  "roles": ["admin"],
  "full_name": "$full_name",
  "email": "$email",
  "metadata": {
    "intelligence": 7
  },
  "enabled": true
}
EOF
)

    curl -X POST "$es_url:$es_port/_security/user/$username" -H 'Content-Type: application/json' -d"$user_body"
    echo "User '$username' created successfully."

else
    echo "Invalid option. Please choose 'index' or 'user'."
fi
