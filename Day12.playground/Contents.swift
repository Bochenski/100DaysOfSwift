import UIKit

//optionals - use ? after the type and nil

var age: Int? = nil
age = 38

//you unwrap an optional by using if let syntax
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}


//or you can use guard let which allows the unwrapped const / var to be used
//outside of the guard let block
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}

//use ! to force unwrap an optional - but beware if you're wrong you'll crash

let str = "5"
let num = Int(str)!

// to avoid having to if let / guard let, you can implicitly unwrap optionals, again if yuo're wrong and access it before it's set yuo'll crash

let ageist: Int! = nil


func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

//nil coalescing allows us to guarantee a concrete type not an optional, we provide a default
let user = username(for: 15) ?? "Anonymous"


//optional chaining via properties:
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()


//optional try

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}


//alternatively to do try?
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

//or try ! (but if we're wrong and it does crash we'll crash out)
try! checkPassword("sekrit")
print("OK!")


//failiable initialisers - return nil if it doesn't work

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}


//typecasting using as?

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}


let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
