

/*
 take a number , if 1 ignore
 take loop with ever increasing number
 another loop inside which will take series of number less than that given number and divide and see if remainder is zero
 if 2 or divisible by 2 then ignore
 3 is first prime number
 divisibility test by 2
*/


package main
import "fmt"
import "time"


func div_2(n uint32) bool {
  if n%2 == 0 {
    return true
  }
  return false
}

func odd_range() []uint32 {
  var r []uint32
  var i uint32
  for i = 1; i <= 1<<31-1; i++ {
    if div_2(i) {
      continue
    }
    r = append(r,i)
  }
  return r
}

func is_prime(n uint32) bool {

    var j uint32
    for j = 3; j <=n; j++ {


      if div_2(j) {
        continue
      }

      if j == n {
        return true
      }

      if n%j == 0 {
        return false
      }

    }
    return false // you MUST return at the end of the function
}


func main() {

  var i uint32
  for i = 1; i <= 1<<31-1; i++ {

    // continue
    if div_2(i) {
        continue
    }

    start := time.Now()
    if is_prime(i) == true {
      elapsed := time.Since(start)
      fmt.Printf("%d\t%s\n",uint32(i),elapsed)
    }

    time.Sleep(1e3* time.Nanosecond)  // sleeping achieved

  }

}
