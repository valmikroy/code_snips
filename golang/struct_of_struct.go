package main

import "fmt"




// First data type and its method
type S1 struct {
    V1 float64
}


func (s S1) multiplyBy2() float64 {
    return 2 * s.V1
}



// Second data type and its method
type S2 struct {
     V2 int
}

func (s S2) additionOf2() int {
     return 2 + s.V2
}



// Tying above data types together with their methods
type S99 struct {
	*S1
	*S2
}



func main() {
	z := S99{ S1: &S1{ V1: 2 }, S2: &S2{ V2: 3 } }
	
	// you can call multiplyBy2 and it will pick up right data type S1 to execute method 
	y := z.multiplyBy2()	
	fmt.Println(y)
	
	x := z.additionOf2()
	fmt.Println(x)
}


// This is how you can build structures of structures and then 
// you can have an interface to execute methods pertaining to 
// given data type 
