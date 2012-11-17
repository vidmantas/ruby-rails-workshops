package main

import (
  "time"
)

func main() {
  println("begin main()")
  go longWait()  // start it concurrently (asynchronously)
  go shortWait()

  println("start sleep in main()")
  time.Sleep(10 * time.Second) // 10s - otherwise, goroutines die immediately
  println("end main()")
}

func longWait() {
  println("begin longWait()")
  time.Sleep(5 * time.Second) // 5s
  println("end longWait()")
}

func shortWait() {
  println("begin shortWait()")
  time.Sleep(2 * time.Second) // 2s
  println("end shortWait()")
}
