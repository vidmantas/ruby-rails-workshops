package main

import (
  "fmt"
  "net/http"
  "strconv"
  "time"
)

// the sleeper http service
// GET http://localhost:9999/500
// it sleeps for 500 milliseconds, then responds "500"

func handler(w http.ResponseWriter, r *http.Request) {
  par := r.URL.Path[1:]
  num, _ := strconv.Atoi(par)

  time.Sleep(time.Duration(num) * time.Millisecond)

  fmt.Fprintln(w, par)
}

func main() {
  http.HandleFunc("/", handler)
  http.ListenAndServe(":9999", nil)
}
