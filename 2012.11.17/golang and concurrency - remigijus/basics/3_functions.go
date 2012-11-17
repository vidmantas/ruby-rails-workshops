package main

import (
  "fmt"
  "math"
  "os"
)

func main() {
  demoArguments()
  demoLambda()
  demoCompose()
  demoMultiReturn()
  demoDefer()
  demoVarArgs()
}


// ------------------------------------------------------------
// 1. arguments are passed by value

type Rect struct {
  X, Y int
}

func demoArguments() {
  arg := Rect{7, 8}
  res := 0
  calcArea(arg, &res) // <- pass by reference
  fmt.Printf("area of %#v is %d\n\n", arg, res)
}

func calcArea(r Rect, area *int) {
  *area = r.X * r.Y
  r.X = 0; r.Y = 0   // has no effect outside
}


// ------------------------------------------------------------
// 2. you can define and execute functions inline

func demoLambda() {
  fv := func() {
    fmt.Println("Hello World!")
  }
  fv()
  fmt.Printf("The type of fv is %T\n", fv)

  func(i int){
    fmt.Printf("%d is printed immediately\n\n", i)
  }(2)
}


// ------------------------------------------------------------
// 3. you can pass functions as arguments and return values;
// closures, naturally :)

func demoCompose() {
  fmt.Println("sin(cos(0.5)) =", compose(math.Sin, math.Cos)(0.5))
}

func compose(f, g func(x float64) float64) func(x float64) float64 {
  return func(x float64) float64 { // a closure
    return f(g(x))
  }
}


// ------------------------------------------------------------
// 4. functions can return multiple values
// this is often used to indicate errors

func demoMultiReturn() {
  low, high := increasing(90, 67)
  fmt.Printf("low: %d, high: %d\n", low, high)

  min, _ := increasing(5, 2)
  fmt.Printf("min: %d\n\n", min)
}

func increasing(x, y int) (low, high int) {
  if x <= y {
    low, high = x, y
  } else {
    low, high = y, x
  }
  return
}


// ------------------------------------------------------------
// 5. function execution can be deferred

func demoDefer() {
  out, err := os.OpenFile("test.out", os.O_WRONLY|os.O_CREATE, 0644)
  if err != nil {
    fmt.Println("cannot write to file")
    return
  }
  defer out.Close() // will be executed before return

  out.WriteString("hi!") // written to file

  fmt.Printf("weird: %d\n\n", f())
}

func f() (ret_val int) {
  defer func() {
    ret_val++
  }()
  return 1 // will return 2
}


// ------------------------------------------------------------
// 6. function can take variable arguments

func demoVarArgs() {
  print(1,2,3)
  print(4)
  print()
  print(5,6,7,8,9)
}

func print(arg ...int) {
  for _, n := range(arg) {
    fmt.Printf("%d ", n)
  }
}
