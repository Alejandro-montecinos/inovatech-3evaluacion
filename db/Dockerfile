FROM mysql:8

# Variables con valores por defecto - serán sobreescritas por el K8s secret (db-secret)
ENV MYSQL_ROOT_PASSWORD=alumno123
ENV MYSQL_DATABASE=tienda
ENV MYSQL_USER=alumno
ENV MYSQL_PASSWORD=alumno123

# Script de inicialización: crea tablas e inserta datos al primer inicio
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

