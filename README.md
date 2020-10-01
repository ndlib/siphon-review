# Siphon Hesburgh Libraries Reformatting Books.  This code is for the docker images and local builds.  The infrastructure code CI/CD needed to run in AWS is available at https://github.com/ndlib/cdk-siphon

# Docker Instructions

## When running docker locally
Local builds will use mysql image whereas AWS uses RDS and variable values come from parameter store.
```

You can also change the ENV variables values for the docker mysql image. Modify the .env file and populate it with passwords needed to create the MySQL database, access the database. The file should look something like the following:

DB_PASSWORD=db_password
MYSQL_ROOT_PASSWORD=mysql_root_password
```

## When running out of AWS
Please see cdk-siphon repository (https://github.com/ndlib/cdk-siphon) for AWS infrastructure code which uses this repo to build container images.

## Running
To run the full stack of services using docker-compose:
```sh
docker-compose -f "docker-compose.yml" up -d --build
```
