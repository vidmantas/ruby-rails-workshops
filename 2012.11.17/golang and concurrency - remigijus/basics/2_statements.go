package main

import (
  "fmt"
  "math/rand"
  "strconv"
  "time"
)

func main() {
  demoIf()
  demoFor()
  demoSwitch()
  demoSwitchType()
}


// ------------------------------------------------------------
// 1. idiomatic usage of "if"

func demoIf() {
  println("DEMO IF")

  if now := time.Now(); now.Year() == 2012 {
    fmt.Println("yay, Mayan prophecy!")
  }
}


// ------------------------------------------------------------
// 2. use "for" - there is no while

func demoFor() {
  println("\nDEMO FOR")

  // -- simple cycle --
  for i := 0; i < 10; i++ {
    a := rand.Int()
    fmt.Printf("%d, ", a)
  }
  fmt.Printf("\n")

  // -- for as while --
  var b int = 5
  for b >= 0 {
    b = b - 1
    fmt.Printf("b = %d\n", b)
  }

  // -- for as iterator --
  slice := []string{"one", "two", "three"}
  for i, s := range slice {
    fmt.Printf("%d: %v\n", i, s)
  }

  // -- strings iterator --
  str := "你好, 地鼠"
  for index, rune := range str {
      fmt.Printf("%-2d      %d      %U '%c' % X\n",
            index, rune, rune, rune, []byte(string(rune)))
  }

  // -- eternal loop --
  z := 0
  for {
    z++
    if z == 3 { break }
  }
  fmt.Printf("Final: %d\n", z)
}


// ------------------------------------------------------------
// 3. switch statement is also very useful

func demoSwitch() {
  println("\nDEMO SWITCH")
  month := 11
  num := 5

  // -- value-based --
  switch month {
    case 12,1,2:  println("Winter")
    case 3,4,5:   println("Spring")
    case 6,7,8:   println("Summer")
    case 9,10,11: println("Autumn")
    default:      println("-")
  }

  // -- condition-based --
  switch {
    case num < 0:
      fmt.Println("Number is negative")
    case num > 0 && num < 10:
      fmt.Println("Number is between 0 and 10")
    default:
      fmt.Println("Number is 10 or greater")
  }
}


// ------------------------------------------------------------
// 4. you can switch on value type

func demoSwitchType() {
  v1 := 21
  fmt.Printf("%v -> %v\n", v1, do(v1))

  v2 := "rabbit"
  fmt.Printf("%v -> %v\n", v2, do(v2))
}

func do(val interface{}) string {
  // val can be of any type
  switch u := val.(type) {
  case int:
    return strconv.Itoa(u*2) // u has type int
  case string:
    mid := len(u) / 2        // split - u has type string
    return u[mid:] + u[:mid] // join
  }
  return "unknown"
}
