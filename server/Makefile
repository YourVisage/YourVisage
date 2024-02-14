sqlc:
	sqlc generate
createdb:
	docker exec -it postgres15 createdb --username=root --owner=root YourVisage
migratedb:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/YourVisage?sslmode=disable" -verbose up
.PHONY: sqlc,createdb