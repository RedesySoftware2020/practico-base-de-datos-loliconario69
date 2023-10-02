CONNECTION:= docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-Pas12AS\!\@
DB_NAME := Datitos

run-compose:
	docker compose up -d

stop-compose:
	docker compose stop && docker rm sqlserver

create-database:
	$(CONNECTION) \
	-d master \
	-Q "CREATE DATABASE $(DB_NAME);"

recreate-database:
	$(CONNECTION) \
	-d master \
	-Q "DROP DATABASE $(DB_NAME); CREATE DATABASE $(DB_NAME);"

run-script:
	$(CONNECTION) \
	-d $(DB_NAME) \
	-i /scripts/database.sql

show-tables:
	$(CONNECTION) \
	-d $(DB_NAME) \
	-Q "SELECT table_name = t.name FROM $(DB_NAME).sys.tables t;"



