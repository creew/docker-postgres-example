IMAGE_NAME=database

build:
	docker build -t ${USER}/${IMAGE_NAME} .

run:
	docker run -d -e POSTGRES_PASSWORD=pass --name service_db -p 54320:5432 ${USER}/${IMAGE_NAME}
