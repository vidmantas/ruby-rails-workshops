package main

import (
  "fmt"
  "net/http"
)

const greeting = "Hello, 世界!"

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintln(w, greeting)
  fmt.Fprintf(w, "You say: %s", r.URL.Path[1:])
}

func main() {
  http.HandleFunc("/", handler)
  http.ListenAndServe(":81", nil)
}
