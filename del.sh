#!/bin/bash
docker stop service_db
docker rm service_db
docker rmi 18396199/database
