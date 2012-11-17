package main

// generation of values on demand

func generateIntegers() chan int {
  yield := make(chan int)
  count := 0
  go func () {
    for {
      yield <- count
      count++
    }
  }()
  return yield
}

func main() {
  integers := generateIntegers()
  println(<-integers)
  println(<-integers)
  println(<-integers)
}

// Extra: futures pattern
// start a lengthy computation, and get a "future" result immediately
/*
func InverseProduct(a Matrix, b Matrix) {
  a_inv_future := InverseFuture(a)
  b_inv_future := InverseFuture(b)

  a_inv := <-a_inv_future
  b_inv := <-b_inv_future

  return Product(a_inv, b_inv)
}

func InverseFuture(a Matrix) {
  future := make(chan Matrix)
  go func() {
    future <- Inverse(a)
  }()
  return future
}
*/
