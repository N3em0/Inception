FROM debian:bookworm-slim

RUN apt-get update -y && \
apt-get install -y --no-install-recommends mariadb-server && \
rm -rf /var/lib/mysql/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh  /bin/mariadb.sh

EXPOSE 3306

RUN chmod +x /bin/mariadb.sh


ENTRYPOINT ["/bin/mariadb.sh"]
