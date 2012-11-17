package main

import (
  "fmt"
  "math/rand"
  "time"
)

const N = 1000

func main() {
  data := make([]float64, N)
  res  := make([]float64, N)
  // prepare data: random values
  for i :=0; i < len(data); i++ {
    data[i] = rand.Float64()
  }

  // [!] semaphore as buffered channel
  sem := make(chan bool, N)

  // parallel for loop
  for i, v := range data {
    go func (i int, v float64) {
      res[i] = process(i, v) // these i,v are copies
      sem <- true
    }(i, v)
  }

  // block: waiting to finish
  for i := 0; i < N; i++ { <-sem }

  fmt.Printf("%v\n", res)
}

func process(idx int, val float64) float64 {
  // simulate work
  time.Sleep(time.Duration(rand.Intn(1000)) * time.Millisecond)
  return float64(idx)
}
