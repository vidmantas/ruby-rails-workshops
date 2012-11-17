package main

import (
  "fmt"
)

func pass(left, right chan int) { left <- 1 + <-right }

// output <- ... (channels) ... <- input

func main() {
  // prepare the chain
  output := make(chan int)
  var left, right chan int = nil, output
  for i := 0; i < 100000; i++ {
    left, right = right, make(chan int)
    go pass(left, right)
  }
  input := right

  // start running!
  input <- 0
  result := <- output  // wait for completion
  fmt.Println(result)  // 100000
}
