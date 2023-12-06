import requests
from requests.auth import HTTPBasicAuth
import json

def find_index_by_name(json_data, partial_index):
    found_data = {}
    for index_name, index_data in json_data.items():
        if partial_index.lower() in index_name.lower():
            found_data[index_name] = index_data
    return found_data

def getRequest(url, username,password):
    try:
        authentication = HTTPBasicAuth(username, password)
        response = requests.get(url, auth = authentication)
        response.raise_for_status()
        json_resp = response.json()
        target_index = entered_index
        found_data = find_index_by_name(json_resp, target_index)
        if found_data:
            print(json.dumps(found_data, indent=2))
        else:
            print(f"No index found with name '{target_index}'")
        #format_json = json.dumps(json_resp, indent=2)
        #print(format_json)
    except requests.exceptions.RequestException as e :
        print(f"Error: {e}")

if __name__ == "__main__":
    elastic_url = input("Enter elastic url: ") 
    username    = "admin"#input("Enter username: ")
    password    = ""#input("Enter password: ")
    entered_index = input("Enter index to search: ")
    getRequest(elastic_url, username,password)