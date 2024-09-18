FROM debian:bullseye

RUN apt-get update -y && apt upgrade -y && apt-get install -y mariadb-server --no-install-recommends

RUN apt-get install -y iputils-ping


COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY script.sh /

RUN chmod +x /script.sh

EXPOSE 3306

CMD ["/script.sh"]
