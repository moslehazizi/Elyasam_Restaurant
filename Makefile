migratefilesup: # nc-0
	migrate create -ext sql -dir db/migration -seq init_schema

postgres: # nc_1
	docker run --name postgresElyasamRestaurant -p 5432:5432 -e POSTGRES_USER=mosleh -e POSTGRES_PASSWORD=1234 -d postgres:latest

postgresstop:
	docker stop postgresElyasamRestaurant

postgresstart:
	docker start postgresElyasamRestaurant

postgresdown:
	docker rm postgresElyasamRestaurant

createdb: # nc_2
	docker exec -it postgresElyasamRestaurant createdb --username=mosleh --owner mosleh Elyasam_Restaurant

dropdb:
	docker exec -it postgresElyasamRestaurant dropdb --username=mosleh Elyasam_Restaurant

execdb: # access to database psql command line
	docker exec -it postgresElyasamRestaurant psql -U mosleh -n Elyasam_Restaurant

migrateup: # nc_3
	migrate -path db/migration -database "postgres://mosleh:1234@localhost:5432/Elyasam_Restaurant?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://mosleh:1234@localhost:5432/Elyasam_Restaurant?sslmode=disable" -verbose down

sqlc: # nc_4
	sqlc generate

run: # Run program
	go run main.go

test: # Test CRUD in database
	go test -v -cover ./...

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/moslehazizi/Elyasam_Restaurant/db/sqlc Store

backup:
	docker exec -t postgresElyasamRestaurant pg_dumpall -c -U mosleh > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

.PHONY: migratefilesup postgres postgresstop postgresstart postgresdown createdb dropdb execdb migrateup migratedown sqlc run mock backup