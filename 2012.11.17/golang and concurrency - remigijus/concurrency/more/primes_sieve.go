package main

import "fmt"

// send the sequence 2, 3, 4, ... to the channel 
func generate() chan int {
  ch := make(chan int)
  go func() {
    for i := 2; ; i++ {
      ch <- i
    }
  }()
  return ch
}

// filter out input values divisible by 'prime', 
// send rest to returned channel
func filter(in chan int, prime int) chan int {
  out := make(chan int)
  go func() {
    for {
      if i := <-in; i%prime != 0 {
        out <- i
      }
    }
  }()
  return out
}

func sieve() chan int {
  out := make(chan int)
  go func() {
    ch := generate()
    for {
      prime := <-ch
      ch = filter(ch, prime)
      out <- prime
    }
  }()
  return out
}

func main() {
  primes := sieve()
  for {
    fmt.Println(<-primes)
  }
}
