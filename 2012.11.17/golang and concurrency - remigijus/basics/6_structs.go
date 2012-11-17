package main

import "fmt"

func main() {
  demoStructs()
  demoMethods()
}


// ------------------------------------------------------------
// 1. initialize structs

type Person struct {
  Name     string
  Age      int
  IsFemale bool
}

type Programmer struct {
  Person
  Languages  string
  Boss       *Person
}

var joe, kim *Programmer // package-global

func demoStructs() {
  fmt.Println("STRUCTS")

  // creating structs and embedding
  bob := Person{"Bob", 29, false}
  fmt.Printf("%#v\n", bob)

  ann := Programmer{Person{"Ann", 25, true}, "Ruby", &bob}
  fmt.Printf("%#v\n", ann)

  // new struct pointers
  joe = new(Programmer)
  joe.Person.Name = "Joe the Brogrammer"
  joe.Person.Age = 22
  fmt.Printf("%#v\n", joe)

  kim = NewProgrammer("Kim", "C#,VB.NET", 25)
  kim.Boss = &ann.Person  // [!]
  fmt.Printf("%#v\n", kim)
}

// factory method
func NewProgrammer(name, langs string, age int) *Programmer {
  person := Person{Name: name, Age: age}  // some of the fields
  return &Programmer{Person: person, Languages: langs}
}
// note: we can force using only factory, by making type name lowercase
// f.ex. this would be illegal outside the package pkg: new(pkg.programmer)


// ------------------------------------------------------------
// 2. methods

// not exported: impossible to call outside of the package
func (a *Person) chatWith(b Person) {
  fmt.Printf("%s is chatting with %s.\n", a.Name, b.Name)
}

// this method can't modify p, and is also more expensive:
// p is passed by value
func (p Programmer) Code(what string) {
  fmt.Printf("%s is coding %s.\n", p.Name, what)
}

func (a *Person) Learn(what string) {
  fmt.Printf("%s has learnt %s.\n", a.Name, what)
}

// overriding for "subclass"
func (p *Programmer) Learn(what string) {
  p.Languages = p.Languages + "," + what
}

func demoMethods() {
  fmt.Println("\nMETHODS")

  joe.Code("new feature")  // valid, eventhough `joe` is a pointer
  joe.chatWith(kim.Person) // method "inheritance"; no implicit type conversion

  joe.Person.Learn("a joke")
  kim.Learn("Go")
  fmt.Printf("%s now knows %s.\n", kim.Name, kim.Languages)
}
