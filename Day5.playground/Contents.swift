func printHelp() {
    let message = """
Welcome to My App!

Run this inside a directory of images and
MyApp will resize them all into thumbnails
"""
    
    print(message)
}

printHelp()

func square(number: Int) -> Int{
    return number * number
}

let result = square(number: 5)
print(result)

//you can have internal and external parameter names
func sayHello(to name: String) {
    print("Hello \(name)!")
}

sayHello(to: "David")

//you can also omit external parameter names

func greet(_ person: String) {
    print("Hello \(person)!")
}
greet("Bob")

//you can specify default parameters:
func acknowledge(_ person: String, nicely: Bool = true) {
    if nicely {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

acknowledge("Taylor")
acknowledge("Jim", nicely: false)


//variadic functions convert 0 or more of type into array of type for use inside function

func squareThese(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
squareThese(numbers: 1,2,3,4,5)

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

//in out params

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
    //you use & to acknowledge the fact it's a pointer / by ref
doubleInPlace(number: &myNum)
