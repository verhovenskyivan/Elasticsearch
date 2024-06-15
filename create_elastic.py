astic.py
1.70 KiB
from elasticsearch import Elasticsearch
import getpass
def create_index(es, index_name):
    index_body = {
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
    es.indices.create(index=index_name, body=index_body)
    print(f"Index '{index_name}' created successfully.")
def create_user(es, username):
    password = getpass.getpass(prompt='Enter password: ')
    user_body = {
        "password": password,
        "roles": ["admin"],
        "full_name": input("Enter full name: "),
        "email": input("Enter email: "),
        "metadata": {
            "intelligence": 7
        },
        "enabled": True
    }
    es.security.put_user(username=username, body=user_body)
    print(f"User '{username}' created successfully.")
def main():
    url = input("Enter Elasticsearch URL (e.g., http://localhost): ")
    port = input("Enter Elasticsearch port (e.g., 9200): ")
    es = Elasticsearch([{'host': url, 'port': port}])
    action = input("Do you want to create an index or a user? (index/user): ").strip().lower()
    if action == "index":
        index_name = input("Enter index name: ").strip()
        create_index(es, index_name)
    elif action == "user":
        username = input("Enter username: ").strip()
        create_user(es, username)
    else:
        print("Invalid option. Please choose 'index' or 'user'.")
if __name__ == "__main__":
    main()
