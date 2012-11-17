package main
import "fmt"
import "math/rand"
import "time"

func worker(id int, jobs <-chan int, results chan<- int) {
  for j := range jobs {
    fmt.Println("worker", id, "processing job", j)
    time.Sleep(time.Duration(rand.Intn(2000)) * time.Millisecond)
    results <- j * 2
  }
}
func main() {
  // in order to use our pool of workers we need to send them work
  // and collect their results.
  jobs := make(chan int, 100)
  results := make(chan int, 100)

  // start up 3 workers, initially blocked because there are no jobs yet.
  for w := 1; w <= 3; w++ {
    go worker(w, jobs, results)
  }

  // send 9 jobs and then close that channel to indicate the end
  for j := 1; j <= 9; j++ {
    jobs <- j
  }
  close(jobs)

  // collect all the results of the work
  for a := 1; a <= 9; a++ {
    <-results
  }
}
