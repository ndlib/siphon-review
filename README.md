# Suma is an open-source mobile web-based assessment toolkit for collecting and analyzing observational data about the usage of physical spaces and services. PLease see https://www.lib.ncsu.edu/projects/suma for information related to suma itself.  This code is for the docker images and local builds.  The infrastructure code CI/CD needed to run in AWS is available at https://github.com/ndlib/cdk-suma

# Docker Instructions

## When running docker locally
Uncomment the following last 2 lines of code in the Dockerfile.apachePHP file so that Apache will start.  Local builds will use mysql image whereas AWS uses RDS and variable values come from parameter store.
```
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apache2"]

You can also change the ENV variables values for the docker mysql image. Modify the .env file and populate it with passwords needed to create the MySQL database, access the database, and login to the suma site. The file should look something like the following:

SUMA_APP_PASSWORD=app_password
SUMA_DB_PASSWORD=db_password
MYSQL_ROOT_PASSWORD=mysql_root_password
```

## When running out of AWS
Please see cdk-suma repository (https://github.com/ndlib/cdk-suma) for AWS infrastructure code which uses this repo to build container images. Comment out the following last 2 lines of code in the Dockerfile.apachePHP file.
```
# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# CMD ["apache2"]
```

## Running
To run the full stack of services using docker-compose:
```sh
docker-compose -f "docker-compose.yml" up -d --build
```
