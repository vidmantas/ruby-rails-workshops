package main

import (
  "fmt"
)

func main() {
  demoSlices()
  demoMaps()
}


// ------------------------------------------------------------
// 1. slices are like pointers to dynamic arrays

func demoSlices() {
  fmt.Println("SLICES")

  // slicing an array
  var array [5]int = [...]int{1, 2, 3, 4, 5} // too lazy to count :)
  var slice []int

  slice = array[1:3] // cut 2 elements: idx=1,2
  fmt.Printf("slice: len=%d, cap=%d --> %v\n", len(slice), cap(slice), slice)
  slice = slice[:4]  // expand over limits!
  fmt.Printf("slice: len=%d, cap=%d --> %v\n", len(slice), cap(slice), slice)

  // making slices - a standard
  slice2 := make([]int, 8)
  fmt.Printf("slice2: len=%d, cap=%d --> %v\n", len(slice2), cap(slice2), slice2)
  slice3 := make([]int, 1, 8)
  fmt.Printf("slice3: len=%d, cap=%d --> %v\n", len(slice3), cap(slice3), slice3)

  slice4 := new([]int) // a pointer, not value!
  fmt.Printf("slice4: len=%d, cap=%d --> %v (%T)\n",
             len(*slice4), cap(*slice4), slice4, slice4)

  // copying
  n := copy(slice2[6:], slice)
  fmt.Printf("copied %d elements\n", n)
  fmt.Printf("slice2: len=%d, cap=%d --> %v\n",
             len(slice2), cap(slice2), slice2)

  // appending
  list := []string{"a", "b"}
  list1 := []string{"x", "y"}
  list2 := append(list, "c", "d")
  list2 = append(list2, list1...)

  // range over it
  for k, v := range list2 {
    fmt.Printf("%d: %s\n", k, v)
  }
}

// ------------------------------------------------------------
// 2. maps are associative arrays

func demoMaps() {
  fmt.Println("\nMAPS")

  // range over it
  data := map[string]string{
    "foo": "bar",
    "hello": "world",
  }
  for k, v := range data {
    fmt.Printf("%s -> %s\n", k, v)
  }

  // making maps
  invert := make(map[string]string, len(data)) // initial capacity
  for k, v := range data {
    invert[v] = k
  }
  fmt.Printf("invert: %v\n", invert)

  // checking if key exists
  if _, exists := data["foo"]; exists {
    fmt.Println("foo exists")
  }
  if _, exists := data["xxx"]; exists {
    fmt.Println("xxx exists?")
  }

  // deleting a key
  delete(data, "hello")
  fmt.Printf("data: %v\n", data)
}
