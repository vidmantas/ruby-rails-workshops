package main

import (
  "fmt"
  "net/http"
  "time"
)

func main() {
  demoTimeout()
  demoTicker1()
  demoTicker2()
}

func demoTimeout() {
  c := make(chan string, 1)

  go realService(c)

  // wait for response OR timeout after 2s
  select {
    case result := <-c:
      fmt.Println(result)
    case <-time.After(2 * time.Second):
      fmt.Println("Timeout!")
  }
}

func fakeService(res chan<- string) {
  time.Sleep(1 * time.Second) // <<< change this to 3
  res <- "Done!"; return
}

// alternative: external call
func realService(res chan<- string) {
  // IMPORTANT: start sleeper.go in a separate process (:9999)
  rsp, err := http.Get("http://localhost:9999/1500")
  if err == nil {
    res <- rsp.Status
  } else {
    res <- err.Error()
  }
}

// ------------------------------------------------------------

func demoTicker1() {
  tick := time.Tick(100 * time.Millisecond)
  boom := time.After(500 * time.Millisecond)
  for {
    select {
      case <-tick:
        fmt.Println("tick.")
      case <-boom:
        fmt.Println("BOOM!\n")
        return
      default:  // [!] this executes when other channels are not available
        fmt.Println("    .")
        time.Sleep(50 * time.Millisecond)
    }
  }
}

func demoTicker2() {
  ticker := time.NewTicker(time.Millisecond * 500)
  go func() {
    for t := range ticker.C {
      fmt.Println("Tick at", t)
    }
  }()
  // when a ticker is stopped it won't receive any more values on its channel
  time.Sleep(time.Millisecond * 1500)
  ticker.Stop()
  fmt.Println("Ticker stopped")
}
