package main

import (
  "flag"
  "fmt"
  "math/rand"
)

// kind of "chinese whispers" game

var in_string = flag.String("s", "chinese whispers", "initial phrase")
var how_many  = flag.Int("n", 100, "how many goroutines")
var mutation  = flag.Float64("p", 0.08, "mutation probability")
const letters = "abcdefghijklmnopqrstuvwxyz "

func pass(left, right chan []byte) {
  slice := <-right
  // change some byte with small probability
  if rand.Float64() < *mutation {
    i := rand.Intn(len(slice))
    j := rand.Intn(len(letters))
    slice[i] = letters[j]
  }
  left <- slice
}

// output <- ... (channels) ... <- input

func main() {
  flag.Parse()
  in_data := []byte(*in_string)

  // prepare the chain
  output := make(chan []byte)
  var left, right chan []byte = nil, output
  for i := 0; i < *how_many; i++ {
    left, right = right, make(chan []byte)
    go pass(left, right)
  }
  input := right

  // start running!
  input <- in_data
  out_data := <- output   // wait for completion
  fmt.Println(string(out_data))
}
