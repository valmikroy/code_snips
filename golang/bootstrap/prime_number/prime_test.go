package main

import "testing"


func TestIsPrime(t *testing.T) {


  if is_prime(9) == true {
    t.Errorf("9 Expected to be divisible by 3")
  }


  if is_prime(5) == false {
    t.Errorf("5 Expected to be a prime number")
  }

  if is_prime(429581) == false {
    t.Errorf("429581 Expected to be a prime number")
  }
}
