package main

import (
  "fmt"
  "reflect"
)

type Person struct {
  name   string    "namestr" // tagged
  age    int
  weight float32
}

func main() {
  p1 := new(Person) // new returns a pointer to Person
  p1.name = "Jonas"; p1.age = 25; p1.weight = 82.4
  ShowTag(p1)       // ShowTag() is now called with this pointer
  ShowIt(p1)
  ShowStruct(*p1)
}

func ShowTag(i interface{}) {
  switch t := reflect.TypeOf(i); t.Kind() { // Get type, switch on Kind()
  case reflect.Ptr:                         // Its a pointer, hence a reflect.Ptr
    tag := t.Elem().Field(0).Tag
    fmt.Printf("tag of %v is %v\n", i, tag)
  }
}

func ShowIt(i interface{}) {
  switch i.(type) {
  case *Person:
    t := reflect.TypeOf(i)   // Go for type meta data
    v := reflect.ValueOf(i)  // Go for the actual values
    tag  := t.Elem().Field(0).Tag
    name := v.Elem().Field(0).String()
    fmt.Println("tag & name: ", tag, name)
  }
}

func ShowStruct(arg interface{}) {
  fmt.Printf("total: %#v\n", arg)
  
  s := reflect.ValueOf(arg) //.Elem()
  atype := s.Type()
  fmt.Printf("type: %s, fields: %d\n", atype, s.NumField())
  for i := 0; i < s.NumField(); i++ {
    f := s.Field(i)
    fmt.Printf("%d: ", i)
    fmt.Printf("%s ", atype.Field(i).Name)
    fmt.Printf("%s = ", f.Type())
    switch f.Kind() {
    case reflect.Int:
      fmt.Printf("%v", f.Int())
    case reflect.String:
      fmt.Printf("%v", f.String())
    case reflect.Float32:
      fmt.Printf("%v", f.Float())
    }
    // fmt.Printf("%v", f.Interface())
    fmt.Printf("\n")
  }
}
