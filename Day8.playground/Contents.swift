import UIKit

//structs

struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"


struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic Sport"
        } else {
            return "\(name) is not an Olympic Sport"
        }
    }
}

var chessBoxing = Sport2(name: "Chess Boxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)


//property observers willSet and didSet

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100


//methods

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()


// mutating methods
// if you assign a struct to a const, all its properties are const
// so you must define methods as mutating (and they'll only work if the struct is var)

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Bob")
person.makeAnonymous()

//let person2 = Person(name: "Jim")
//person2.makeAnonymous() //this will not compile as you can't call mutating function

//methods on strings

let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())


//methods on arrays

var toys = ["Woody"]
print(toys.count)

toys.append("Buzz")
toys.firstIndex(of: "Buzz") //zero base indexing

print(toys.sorted())
toys.remove(at: 0)

