package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {
	url := fmt.Sprintf("http://localhost:3001/hospitals")

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	if err := json.NewDecoder(resp.Body).Decode(&players); err != nil {
		log.Fatal(err)
	}

	http.HandleFunc("/players", func(w http.ResponseWriter, r *http.Request) {
		b, err := json.MarshalIndent(players, "", "  ")
		if err != nil {
			fmt.Println(err)
		}
		io.WriteString(w, string(b))
	})

	if err := http.ListenAndServe(":4001", nil); err != nil {
		log.Fatal(err)
	}

}

type player struct {
	Name    string `json:"name"`
	Address string `json:"address"`
	City    string `json:"city"`
}

var players []player
