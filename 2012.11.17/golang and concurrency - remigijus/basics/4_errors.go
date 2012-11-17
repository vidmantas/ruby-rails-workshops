package main

import (
  "errors"
  "fmt"
  "os"
)

func main() {
  demoErrors()
  demoErrorsCustom()
  demoPanic(f, true)
  demoPanic(f, false)
  demoPanicFinal()
}


// ------------------------------------------------------------
// 1. error handling

func demoErrors() {
  var err error

  err = checkFile("errors.go")
  fmt.Println(err)

  err = checkFile("?wrong?")
  fmt.Println(err)
}

func checkFile(name string) error {
  f, err := os.Open(name)
  if err != nil {
    return err
  }
  if _, err = f.Stat(); err != nil {
    return err
  }
  return nil
}


// ------------------------------------------------------------
// 2. custom errors

func demoErrorsCustom() {
  fmt.Println("\nERRORS CUSTOM")

  a, err := getAnswerTo("life, universe and everything")
  fmt.Printf("answer is %d, error %v\n", a, err)

  b, err := getAnswerTo("whatever")
  fmt.Printf("answer is %d, error %v\n", b, err)
}

func getAnswerTo(question string) (int, error) {
  if question != "life, universe and everything" {
    return 0, errors.New("invalid question")
  }
  return 42, nil
}


// ------------------------------------------------------------
// 3. panic and recover

func demoPanic(f func(bool), fail bool) {
  defer func() {
    if x := recover(); x != nil {
      fmt.Printf("recovered: %v\n", x)
    }
  }()

  f(fail)
}

func f(fail bool) {
  if fail {
    panic("bad things happened!")
  }
}


// ------------------------------
// 4. unrecovered runtime panic -> exit

func demoPanicFinal() {
  fmt.Println("\nRUNTIME PANIC")

  a := 1; b := 0
  x := a / b // panic: runtime error: integer divide by zero
  fmt.Println(x)

  // P.S.
  // x := 1 / 0   // this won't compile
  // _  = a / b   // this won't fail: just ignored
}
