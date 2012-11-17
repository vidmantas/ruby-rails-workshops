package main

import (
  "fmt"
  "sort"
)

func main() {
  demoInterfaces()
  demoEmbedding()
  demoAssertions()
  demoEmpty()
  demoSorting()
}


// ------------------------------------------------------------
// 1. declaration

type Speaker interface {
  Speak()
}

type Human struct {
  Name  string
}
func (h *Human) Speak() {
  fmt.Printf("%s says derp!\n", h.Name)
}
func (h *Human) Drink(what string) {
  fmt.Printf("%s drinks %s.\n", h.Name, what)
}

type Robot struct {
  Code  string
}
func (r *Robot) Speak() {
  fmt.Printf("%s beeps.\n", r.Code)
}

func demoInterfaces() {
  fmt.Println("INTERFACES")

  var s1 Speaker = &Human{"Luke Skywalker"} // (methods were declared on pointers)
  var s2 Speaker = &Robot{"R2-D2"}

  s1.Speak()
  s2.Speak()
  // s1.Drink("water") // <- s1.Drink undefined (type Speaker has no field or method Drink)
}


// ------------------------------------------------------------
// 2. embedding

type Drinker interface {
  Drink(string)  // shortcut
}

type SpeakDrinker interface {
  Speaker
  Drinker
}

func demoEmbedding() {
  fmt.Println("\nEMBEDDING")

  var se SpeakDrinker = &Human{"John"}
  se.Drink("beer")
  se.Speak()
}


// ------------------------------------------------------------
// 3. assertions

func demoAssertions() {
  fmt.Println("\nASSERTIONS")

  list := []Speaker{ &Human{"Bob"}, &Robot{"A1"} }
  chat(list)
}

func chat(speakers []Speaker) {
  for _, s := range speakers {
    s.Speak()

    if h, ok := s.(*Human); ok {
      h.Drink("water")
    }
    // also could use switch by type
  }
}


// ------------------------------------------------------------
// 4. empty

type Any interface{} // an alias to empty interface

func demoEmpty() {
  fmt.Println("\nVARIOUS")

  // -- using empty interface
  list := []Any{ &Human{"Bob"}, &Robot{"A1"}, 3.14159 }
  for i, v := range list {
    fmt.Printf(" %d: %v\n", i, v)
  }

  // example from stdlib, package fmt:
  // func Printf(format string, a ...interface{}) (n int, errno error)
}


// ------------------------------------------------------------
// 5. sorting
// http://golang.org/pkg/sort/#Interface

type People []Human

func (s People) Len() int { return len(s) }
func (s People) Swap(i, j int) { s[i], s[j] = s[j], s[i] }

type PeopleByNameAsc struct { People }
func (s PeopleByNameAsc) Less(i, j int) bool { return s.People[i].Name < s.People[j].Name }

type PeopleByNameDesc struct { People }
func (s PeopleByNameDesc) Less(i, j int) bool { return s.People[i].Name > s.People[j].Name }

func demoSorting() {
  var slice = People{
    Human{"Greg"},
    Human{"Bob"},
    Human{"John"},
  }

  sort.Sort(PeopleByNameAsc{slice})
  fmt.Println(slice)

  sort.Sort(PeopleByNameDesc{slice})
  fmt.Println(slice)
}
