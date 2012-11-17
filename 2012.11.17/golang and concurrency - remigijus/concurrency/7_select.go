package main

import (
  "fmt"
  "time"
  "runtime"
)

func main() {
  // [!] how many CPUs we can use?
  runtime.GOMAXPROCS(1) // experiment!

  ch1 := make(chan int)
  ch2 := make(chan int)

  go pump1(ch1)
  go pump2(ch2)
  go suck(ch1, ch2)

  time.Sleep(1 * time.Second)
}

func pump1(ch chan int) {
  for i:=1 ; ; i++ {
    ch <- i
  }
}

func pump2(ch chan int) {
  for i:=1; ; i++ {
    ch <- (-i)
  }
}

// select-statement implements a kind of listener pattern
func suck(ch1,ch2 chan int) {
  for {
    // [!] chooses in random from available channel
    select {
      case v := <- ch1:
        fmt.Printf("ch1: %d\n", v)
      case v := <- ch2:
        fmt.Printf("ch2: %d\n", v)
    }
  }
}
