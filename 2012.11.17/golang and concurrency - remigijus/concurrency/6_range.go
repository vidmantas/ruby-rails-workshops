package main

import (
  "fmt"
  "time"
)

func main() {
  pipe := pump()
  suck(pipe)
  // run for some time
  time.Sleep(500 * time.Millisecond)
}

// starts infinite producer of data, returns the "pipe"
func pump() <-chan int {
  ch := make(chan int)
  go func() {
    for i := 0; ; i++ {
      ch <- i
    }
  }()
  return ch
}

// starts consumer in a separate goroutine
func suck(ch <-chan int) {
  go func() {
    for v := range ch { // stops when closed
      fmt.Println(v)
    }
  }()
}
