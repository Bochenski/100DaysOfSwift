import UIKit

// arrays
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
beatles[1]


// sets - unordered and unique members

let colours = Set(["red", "green", "blue"])

let colours2 = Set(["red", "green", "blue", "red"])

//tuples - immutable
var name = (first: "Taylor", last: "Swift", middle: "bob")
name.2
name.first

// Dictionaries
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

heights["Ed Sheeran"]
heights["David", default: 0.0]

//empty collectiokns
var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()

var words = Set<String>()
var numbers = Set<Int>()

//can also use this syntax for Dictionaries and arrays
var scores = Dictionary<String,Int>()
var results2 = Array<Int>()


//Enums
let result3 = "failure"
let result4 = "failed"
let result5 = "fail"

enum Result {
    case success
    case failure
}

let result6 = Result.failure

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

enum Planet: Int {
    case mercury = 1 //swift will increment from here
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3)

