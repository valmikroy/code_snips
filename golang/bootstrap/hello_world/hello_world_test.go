package main

import "testing"

func TestHello(t *testing.T) {
  str := string_one()

  if str != "Hello World +" {
    t.Errorf("Unexpected string returned")
  }

  str = string_two()

  if str != "Hello World ++" {
    t.Errorf("Unexpected string returned")
  }
}
