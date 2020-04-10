### Dockerfile
Используем стандартный образ postgres и копируем два скрипта в стандартную папку docker-entrypoint-initdb.d.<br>
Скрипты выполняться по порядку, исходя из имени скрипта, при создании контейнера.<br>
00_init.sh - создает пользователя и базуданных.<br>
01_create_tables.sh - создает таблицу и заполняет ее.<br>
### Makefile
build: создаем докер образ с именем ${USER}/database<br>
run: создаем докер контейнер с именем service_db, перекидываем со стандартного порта 5432 на порт 54320<br>
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
url = jdbc:postgresql://localhost:54320<br>
username = admin<br>
password = pass<br>
