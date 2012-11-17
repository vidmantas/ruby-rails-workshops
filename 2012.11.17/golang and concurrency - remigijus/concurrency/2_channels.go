package main

import "fmt"

func main() {
  ch := make(chan string)
  go send(ch)
  recv(ch)
}

func send(ch chan string) {
  ch <- "Vilnius"
  ch <- "Kaunas"
  ch <- "Klaipėda"
  ch <- "Šiauliai"
  ch <- "Panevėžys"
  close(ch) // [!] one way to signal an end
}
// (1) it is not necessary to close channels, not like files
// (2) only the sender should close a channel, never the receiver

func recv(ch chan string) {
  for {
    input, isopen := <-ch // testing for end
    if !isopen {
      break
    }
    fmt.Printf("%s ", input)
  }
}
