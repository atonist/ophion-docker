# ophion-docker

You need to pass your configs and certs into docker for this to work or edit the docker-compose.yml & docker-compse up -d.

```
docker run -d \
    -p 5000:5000 \
    -p 6665-6669:6665-6669 \
    -p 6697:6697 \
    -p 9999:9999 \
    -v /location/to/ophion/config/:/usr/local/etc \
    -v /location/to/ophion/certs/:/certs \
    -v /location/to/ophion/logs:/usr/local/logs \
    dbrown786/ophion:latest
```

The latest dockerized ophion can be pulled via docker pull dbrown786/ophion:latest.
