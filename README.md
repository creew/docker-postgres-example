### Dockerfile
Используем стандартный образ postgres и копируем два скрипта в стандартную папку docker-entrypoint-initdb.d.<br>
Скрипты выполняться по порядку, исходя из имени скрипта, при создании контейнера.<br>
00_init.sh - создает пользователя и базы данных.<br>
01_create_tables_in_service_db.sh - создает таблицу для CRUD в базе данных service_db и заполняет ее.<br>
02_create_tables_in_bank_db.sh - создает таблицу для REST Rest интерфейча в базе данных bank_db и заполняет ее.<br>

### Makefile
build: создаем докер образ с именем ${USER}/database<br>
run: создаем докер контейнер с именем service_db<br>
all: создаем докер образ и контейнер
### Build image and container
make build<br>
make run<br>
### Delete image and container
./del.sh<br>
### Start and stop container
docker start service_db<br>
docker stop service_db<br>
### Connect to database
driver = org.postgresql.Driver<br>
url = jdbc:postgresql://localhost:5432/{basename}<br>
username = admin<br>
password = pass<br>
