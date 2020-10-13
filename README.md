# ophion-docker

You need to pass your configs and certs into docker for this to work.

docker run -d -p 6665-6669:6665-6669 -p 6697:6697 -p 9999:9999 -p 5000:5000 -v /home/user/ophion-docker/config:/ircd/etc -v /home/user/ophion-docker/certs/:/certs ophion


The latest dockerized ophion can be pulled via docker pull dbrown786/ophion:latest.
