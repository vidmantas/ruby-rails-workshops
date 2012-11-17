package main

import (
	"fmt"
	"encoding/json"
	"log"
	"os"
)

// NOTE: add json tags

type Address struct {
	Type      string     `json:"type"`
	Number    uint       `json:"nr"`
	Street    string     `json:"street"`
	City      string     `json:"city"`
}

type VCard struct {
	FirstName string     `json:"first_name"`
	LastName  string     `json:"last_name"`
	Addresses []*Address `json:"addresses"`
	Remark    string     `json:"remark,omitempty"`
}

func main() {
	pa := &Address{"namų", 7, "Kosmonautų", "Vievis"}
	wa := &Address{"darbo", 15, "Konstitucijos", "Vilnius"}
	vc := VCard{"Jonas", "Jonaitis", []*Address{pa,wa}, ""}
	fmt.Printf("%v: \n", vc)

	// using marshal
	js, _ := json.MarshalIndent(vc, "", "  ")
	fmt.Printf("JSON format: %s", js)

	// using an encoder
	file, _ := os.OpenFile("vcard.json", os.O_CREATE|os.O_WRONLY, 0)
	defer file.Close()
	enc := json.NewEncoder(file)
	err := enc.Encode(vc)
	if err != nil {
		log.Println("Error in encoding json")
	}
}
