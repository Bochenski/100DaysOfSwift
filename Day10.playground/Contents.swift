//classes need to define their own init function
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String){
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

//inheritance, and final (cannot be further inherited)
final class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    
    override func makeNoise() {
        print("Yip!")
    }
}

let pops = Poodle(name: "Poppy")
pops.makeNoise() //uses override

//copying class objects refers to same underlying instance (byref).
//copying structs gets you a new struct (byval)

//also no need to mark properties mutating, unlike classes
class Singer {
    var name = "Taylor Swift"
}

class Singer2 {
    let name = "Taylor Swift"
}

let singer = Singer()
print(singer.name) //works even though singer is a const
let singer2 = Singer2()
//singer2.name = "bob" //wont' work as the class property is a const
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name) //original singer is now Justin

struct Soloist {
    var name = "Taylor Swift"
}

var soloist = Soloist()
print(soloist.name)

var soloistCopy = soloist
soloistCopy.name = "Something else"

print(soloistCopy.name)
print(soloist.name) //doesn't change


//deinit is called when an instance of a class is destroyed
class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}


