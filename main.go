package main

import (
	"database/sql"
	"log"

	"github.com/moslehazizi/Elyasam_Restaurant/api"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
	"github.com/moslehazizi/Elyasam_Restaurant/util"

	_ "github.com/lib/pq"
)

func main() {

	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("connot laod config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Connot connect to the database:", err)
	}
	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
        log.Fatal("cannot create server:", err)
    }

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("connot start server:", err)
	}

}