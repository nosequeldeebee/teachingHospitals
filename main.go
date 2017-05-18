package main

import (
	"database/sql"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

type hospital struct {
	Name    string `json:"name"`
	Address string `json:"address"`
	City    string `json:"city"`
	State   string `json:"state"`
	Zip     string `json:"zip"`
}

var hospitals []hospital

func main() {

	//for db authentication
	user := flag.String("u", "", "db username")
	pwd := flag.String("p", "", "db password")
	flag.Parse()

	//connect to db
	dbinfo := fmt.Sprintf("user=%s password=%s dbname=test sslmode=disable", *user, *pwd)
	db, err := sql.Open("postgres", dbinfo)
	if err != nil {
		log.Fatal("couldn't connect to db", err)
	}
	defer db.Close()

	//perform query and populate `hospitals` slice
	rows, err := db.Query("SELECT * FROM teachinghospital")
	if err != nil {
		log.Fatal("couldn't query db", err)
	}
	defer rows.Close()

	var (
		name, address, city, state, zip string
	)

	for rows.Next() {
		err := rows.Scan(&name, &address, &city, &state, &zip)
		if err != nil {
			log.Fatal("couldn't scan db results", err)
		}
		hospitals = append(hospitals, hospital{Name: name, Address: address, City: city, State: state, Zip: zip})
	}

	if err := rows.Err(); err != nil {
		log.Println(err)
	}

	//serve front end
	go func() {
		http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("./src/static/"))))

		if err := http.ListenAndServe(":9090", nil); err != nil {
			log.Fatal(err)
		}
	}()

	//serve `hospitals` slice through json web api
	http.HandleFunc("/hospitals", getHospitals)
	if err := http.ListenAndServe(":3001", nil); err != nil {
		log.Fatal("couldn't start server", err)
	}

}

func getHospitals(w http.ResponseWriter, r *http.Request) {
	//set headers for CORS
	if origin := r.Header.Get("Origin"); origin != "" {
		w.Header().Set("Access-Control-Allow-Origin", origin)
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
		w.Header().Set("Access-Control-Allow-Headers",
			"Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
	}
	// Stop here if its Preflighted OPTIONS request
	if r.Method == "OPTIONS" {
		return
	}

	//prettify api endpoint
	b, err := json.MarshalIndent(hospitals, "", " ")
	if err != nil {
		fmt.Println("couldn't indent json", err)
	}
	io.WriteString(w, string(b))
}
