#!/bin/bash
set -e

# echo "Config files for suma service"
# cd "$SUMA_APP_DIR/suma/service/config"
# sed -i 's@host.*$@host: '"$SUMA_DB_HOST"'@' config.yaml
# sed -i 's@dbname.*$@dbname: '"$SUMA_DB_NAME"'@' config.yaml
# sed -i 's@DB_USERNAME@'"$SUMA_DB_USER"'@' config.yaml
# sed -i 's@DB_PASSWORD@'"$SUMA_DB_PASSWORD"'@' config.yaml
# sed -i 's@user: admin@user: '"$SUMA_APP_USER"'@' config.yaml
# sed -i 's@pass: admin@pass: '"$SUMA_APP_PASSWORD"'@' config.yaml

# echo "Config files for suma analysis tools"
# cd "$SUMA_APP_DIR/suma/analysis/config"
# sed -i 's@baseUrl:.*@baseUrl: '"$SUMA_HOST_URL"'\/sumaserver\/query@' config.yaml
# sed -i 's@analysisBaseUrl:.*@analysisBaseUrl: '"$SUMA_HOST_URL"'\/suma\/analysis\/reports@' config.yaml

# echo "Config files for Session Manager application"
# cd "$SUMA_APP_DIR/sm"
# sed -i 's@SUMASERVER_URL\", \"\");.*@SUMASERVER_URL", \"'"$SUMA_HOST_URL"'\/sumaserver\");@' config.php
# sed -i 's@SUMA_REPORTS_URL\", \"\");.*@SUMA_REPORTS_URL", \"'"$SUMA_HOST_URL"'\/suma\/analysis\/reports\");@' config.php
# sed -i 's@MYSQL_DATABASE\", \"\");.*@MYSQL_DATABASE", \"'"$SUMA_DB_NAME"'\");@' config.php
# sed -i 's@MYSQL_USER\", \"\");.*@MYSQL_USER", \"'"$SUMA_DB_USER"'\");@' config.php
# sed -i 's@MYSQL_PASSWORD\", \"\");.*@MYSQL_PASSWORD", \"'"$SUMA_DB_PASSWORD"'\");@' config.php
# sed -i 's@MYSQL_HOST\", \"\");.*@MYSQL_HOST", \"'"$SUMA_DB_HOST"'\");@' config.php

# echo "Config file for Import application"
# cd "$SUMA_APP_DIR/import"
# sed -i 's@$sumaserver_url =.*@$sumaserver_url = \"'"$SUMA_HOST_URL"'\/sumaserver\";@' config.php

cd "$APP_DIR/config"

echo "Modify database file"
sed -i 's/{{ database_host }}/'"$DB_HOST"'/g' database.yml
sed -i 's/{{ database_username }}/'"$DB_NAME"'/g' database.yml
sed -i 's/{{ database_password }}/'"$DB_PASSWORD"'/g' database.yml

echo "Modify secrets file"
sed -i 's/{{ auth_server_id }}/'"$AUTH_SERVER_ID"'/g' secrets.yml
sed -i 's/{{ base_auth_url }}/'"$BASE_AUTH_URL"'/g' secrets.yml
sed -i 's/{{ client_id }}/'"$CLIENT_ID"'/g' secrets.yml
sed -i 's/{{ client_secret }}/'"$CLIENT_SECRET"'/g' secrets.yml
sed -i 's/{{ redirect_url }}/'"$REDIRECT_URL"'/g' secrets.yml
sed -i 's/{{ secret_key_base }}/'"$SECRET_KEY_BASE"'/g' secrets.yml

echo "Start server"
exec nginx