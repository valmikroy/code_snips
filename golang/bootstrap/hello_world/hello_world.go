package main

import "fmt"


// Both string_one() and string_two() are essentially the same
// except its returning string

func string_one() string {
  ret := "Hello World +" // initialize and assign a string
  return ret
}

func string_two() string  {
    var ret = "Hello World +" + "+"  // this is another way of initalizing variable compare to line 10 above
                                    // along with string concatnation example
    return  ret
}




func main() {
  str := string_one() // Initialized and assigned
  fmt.Println(str)

  str = string_two() // now this is just re-assignment
  fmt.Println(str)

  var num int // int variable gets initialized to 0
  fmt.Println(num)

  var flag bool // Boolean variable gets initialized to false
  fmt.Println(flag)

  var MaxInt uint64  = 1<<64 - 1  // maximum int number (2^64 - 1)
  fmt.Printf("Type: %T Value: %v\n", MaxInt,  MaxInt) // Printing type of variable

  const d = 1e19  // define constatnt
  fmt.Println(d)
  fmt.Println(uint64(d)) // typecasting of constant

}
