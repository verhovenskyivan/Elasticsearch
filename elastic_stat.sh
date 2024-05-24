#!/bin/bash

# Проверка аргументов
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <http://elastic:port> <query>"
    echo "Available queries:"
    echo "  cluster_health    - Get cluster health status"
    echo "  cluster_state     - Get cluster state"
    echo "  nodes_info        - Get information about nodes"
    echo "  cluster_stats     - Get cluster statistics"
    echo "  nodes_stats       - Get nodes statistics"
    exit 1
fi

# Переменные
ELASTIC_URL=$1
QUERY=$2

# Функции запросов
cluster_health() {
    curl -X GET "$ELASTIC_URL/_cluster/health?pretty"
}

cluster_state() {
    curl -X GET "$ELASTIC_URL/_cluster/state?pretty"
}

nodes_info() {
    curl -X GET "$ELASTIC_URL/_nodes?pretty"
}

cluster_stats() {
    curl -X GET "$ELASTIC_URL/_stats?pretty"
}

nodes_stats() {
    curl -X GET "$ELASTIC_URL/_nodes/stats?pretty"
}

# Выполнение выбранного запроса
case $QUERY in
    cluster_health)
        cluster_health
        ;;
    cluster_state)
        cluster_state
        ;;
    nodes_info)
        nodes_info
        ;;
    cluster_stats)
        cluster_stats
        ;;
    nodes_stats)
        nodes_stats
        ;;
    *)
        echo "Unknown query: $QUERY"
        exit 1
        ;;
esac
