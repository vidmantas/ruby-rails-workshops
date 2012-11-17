package main

import "fmt"

// using globals is discouraged
var data = make(chan string)
var done = make(chan bool)

func produce() {
  for i := 0; i < 26; i++ {
    data <- fmt.Sprintf("%c", 65+i)
  }
  done <- true // another way to signal an end
}

func consume() {
  for {
    msg := <-data
    fmt.Print(msg)
  }
}

func main() {
  go produce()
  go consume()
  <-done // waiting...
}
