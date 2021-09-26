FROM mariadb:10.5
COPY init/*.sql /docker-entrypoint-initdb.d/
COPY conf/my.cnf /etc/mysql/conf.d/custom.cnf
EXPOSE 3306
