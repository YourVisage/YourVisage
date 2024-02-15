package test

import (
	"database/sql"
	"log"
	"os"
	"testing"

	db "github.com/YourVisage/YourVisage/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:root@localhost:5432/YourVisage?sslmode=disable"
)

var testQueries *db.Queries

func TestMain(m *testing.M) {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Panic("unable to connect database", err)
	}

	testQueries = db.New(conn)
	os.Exit(m.Run())
}
