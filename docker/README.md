# Running in development
To run this locally, from the root directory:
```bash
docker build . -f docker/Dockerfile -t siphon
docker run -p 443:443 --env PORT=443 \
  --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --env AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
  --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  --env AWS_REGION=$AWS_REGION \
  --env-file ./docker/dev_env \
  -it siphon sh ./docker/start.sh
```

Note: The if you change the PORT env, you will need to match the port in the -p option above

If you want to simulate Chamber pulling any secrets from SSM, you will need to provide AWS credentials as outlined above.

Otherwise, you will need to create the /docker/dev_env file as needed. The environment variables that are expected can be found in [the database.yml file for the Ruby application.](../config/database.yml)


# Running in production
In production, the application's expected environment key/value pairs will be retrieved from SSM at the given ENV_SSM_PATH, while the AWS environment keys will be taken care of by ECS. Below is a simulated example of how this will be run when deployed as an ECS Task.
```bash
docker run -p 80:80 --env PORT=80 \
  --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --env AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
  --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  --env AWS_REGION=$AWS_REGION \
  --env ENV_SSM_PATH=all/siphon/prod \
  -it siphon
```
