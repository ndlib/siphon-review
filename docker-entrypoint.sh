#!/bin/sh
set -e

echo "Modify config file for database"
sed -i 's/{{ database_host }}/'"$DB_HOST"'/g' "$APP_DIR/config/database.yml"
sed -i 's/{{ database_username }}/'"$DB_NAME"'/g' "$APP_DIR/config/database.yml"
sed -i 's/{{ database_password }}/'"$DB_PASSWORD"'/g' "$APP_DIR/config/database.yml"

echo "Modify config file for secrets"
sed -i 's/{{ auth_server_id }}/'"$AUTH_SERVER_ID"'/g' "$APP_DIR/config/secrets.yml"
sed -i 's/{{ client_id }}/'"$CLIENT_ID"'/g' "$APP_DIR/config/secrets.yml"
sed -i 's/{{ client_secret }}/'"$CLIENT_SECRET"'/g' "$APP_DIR/config/secrets.yml"
sed -i 's/{{ secret_key_base }}/'"$SECRET_KEY_BASE"'/g' "$APP_DIR/config/secrets.yml"

# echo "Modify config file for URL secrets"
# sed -i 's/{{ base_auth_url }}/'"$BASE_AUTH_URL"'/g' "$APP_DIR/config/secrets.yml"
# sed -i 's/{{ redirect_url }}/'"$REDIRECT_URL"'/g' "$APP_DIR/config/secrets.yml"

echo "Start Service"
exec nginx
