package main

import "fmt"
import "time"

func main() {
  c := make(chan int)
  // c <- 7  // this would deadlock!

  // buffered channel, no blocking!
  // c := make(chan int, 1)
  // println("capacity: ", cap(c))

  go func() {
    time.Sleep(10 * time.Second)
    x := <-c
    fmt.Println("received", x)
  }()

  fmt.Println("sending...")
  c <- 42
  fmt.Println("data sent")
}
