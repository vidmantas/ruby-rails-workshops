package main

import (
  "fmt"
  "strconv"
)

func main() {
  demoBasicTypes()
  demoPointers()
  demoStrings()
  demoStrconv()
}


// ------------------------------------------------------------
// 1. Basic types available in Go

func demoBasicTypes() {
  fmt.Println("BASIC TYPES")

  t := true         // bool
  i := 1            // int
  var j uint64 = 42 // uint64
  pi := 3.142       // float64
  z  := 5 + 10i     // complex128
  greeting := "Hi!" // string
  wee := '囧'       // int32
  mult := func(x, y int) int { return x * y }

  var undef int32   // value: 0
  var ptr *uint     // value: nil

  // printing types & values of heterogeneous list (see file 7)
  values := []interface{}{t, i, j, pi, z, greeting, wee, mult, undef, ptr}
  for _, v := range values {
    fmt.Printf("%T --> %v\n", v, v)
  }
}


// ------------------------------------------------------------
// 2. you can make pointers to anything

func demoPointers() {
  fmt.Println("\nPOINTERS")

  i1 := 10
  fmt.Printf("int: %d, location in memory: %p\n", i1, &i1)

  var i2 *int = &i1
  *i2++
  fmt.Printf("i1: %d, i2: %d\n", i1, *i2)
}


// ------------------------------------------------------------
// 3. strings are immutable; to update, convert it to byte array

func demoStrings() {
  fmt.Println("\nSTRINGS")

  s := "hello"

  c := []byte(s)  //convert string to byte array
  c[0] = 'c'
  s2 := string(c) //convert byte array to string

  fmt.Printf("%s => %s\n", s, s2)
}


// ------------------------------------------------------------
// 4. string conversion to integer and vice-versa

func demoStrconv() {
  fmt.Println("\nSTRCONV")

  i, err := strconv.Atoi("aaa")
  if err != nil {
    fmt.Println(err)
  }
  fmt.Printf("Got: %v\n", i)

  i, _ = strconv.Atoi("42")
  fmt.Printf("Got: %v\n", i)

  s := strconv.FormatInt(17, 16)
  fmt.Printf("Hexadecimal: %v\n", s)
}
