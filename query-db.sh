#!/bin/bash
# @Author: Klaudie <klaudie@foxprofi.cz>
# Database query wrapper for internal API

# Load configuration from .env
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# Parse .env file
API_URL=$(grep -E '^INTERNAL_API_URL=' "$ENV_FILE" | cut -d '=' -f2- | tr -d '"' | tr -d "'")
API_KEY=$(grep -E '^INTERNAL_API_KEY=' "$ENV_FILE" | cut -d '=' -f2- | tr -d '"' | tr -d "'")

if [ -z "$API_URL" ] || [ -z "$API_KEY" ]; then
    echo "Error: INTERNAL_API_URL or INTERNAL_API_KEY not set in .env"
    exit 1
fi

if [ "$1" == "--help" ] || [ -z "$1" ]; then
    echo "Usage:"
    echo "  ./query-db.sh --table users --limit 5"
    echo "  ./query-db.sh --query 'SELECT * FROM users WHERE role=\"domina\"'"
    exit 0
fi

# Build JSON payload
if [[ "$*" == *"--query"* ]]; then
    # Extract query
    QUERY=$(echo "$*" | sed -n "s/.*--query '\([^']*\)'.*/\1/p")
    JSON="{\"query\":\"$QUERY\"}"
else
    # Parse structured query
    TABLE=$(echo "$*" | sed -n 's/.*--table \([^ ]*\).*/\1/p')
    LIMIT=$(echo "$*" | sed -n 's/.*--limit \([^ ]*\).*/\1/p')

    JSON="{\"table\":\"$TABLE\""
    [ -n "$LIMIT" ] && JSON="$JSON,\"limit\":$LIMIT"
    JSON="$JSON}"
fi

# Execute request
curl -s -X POST "$API_URL" \
    -H "Content-Type: application/json" \
    -H "X-Internal-Key: $API_KEY" \
    -d "$JSON" | python3 -m json.tool
