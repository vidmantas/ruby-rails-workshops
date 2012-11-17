package main

import (
  "fmt"
  "math/rand"
  "time"
)

func hit(msg string, in <-chan string, out chan<- string) {
  for recv := range in {
    <- time.After(time.Duration(100+rand.Intn(500)) * time.Millisecond)
    fmt.Println(recv)
    out <- msg
  }
}

func main() {
  one, two := make(chan string), make(chan string)

  go hit("Ping!", two, one)
  go hit("Pong!", one, two)

  one <- "Ping!"
  <- time.After(10 * time.Second)
}
