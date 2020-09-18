#!/bin/sh
set -e

echo "Config files for service"
perl -pe "s/\{\{ database_host \}\}/$DB_HOST/g" "$APP_DIR/config/database.yml"
perl -pe "s/\{\{ database_username \}\}/$DB_NAME/g" "$APP_DIR/config/database.yml"
perl -pe "s/\{\{ database_password \}\}/$DB_PASSWORD/g" "$APP_DIR/config/database.yml"
perl -pe "s/\{\{ auth_server_id \}\}/$AUTH_SERVER_ID/g" "$APP_DIR/config/secrets.yml"
perl -pe "s/\{\{ base_auth_url \}\}/$BASE_AUTH_URL/g" "$APP_DIR/config/secrets.yml"
perl -pe "s/\{\{ client_id \}\}/$CLIENT_ID/g" "$APP_DIR/config/secrets.yml"
perl -pe "s/\{\{ client_secret \}\}/$CLIENT_SECRET/g" "$APP_DIR/config/secrets.yml"
perl -pe "s/\{\{ redirect_url \}\}/$REDIRECT_URL/g" "$APP_DIR/config/secrets.yml"
perl -pe "s/\{\{ secret_key_base \}\}/$SECRET_KEY_BASE/g" "$APP_DIR/config/secrets.yml"

echo "Start Service"
# source /etc/nginx/envvars
exec nginx
