import UIKit

let name = "Tim McGraw"
// constants can't be changed
//name = "Romeo"

//you must name things uniquely
//var name = "bob"

// type annotations or infernce
var name2: String
var name3 = "bob"


//start vars and constants with lower case, types with upper case
name2 = "Tim McGraw"

var age: Int
age = 25

//type safety - cannot change variable types
//name = 25
//age = "Tim McGraw"


//Floats and doubles - use double as it has highest accuracy (double the accuracy)
var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333 //note the lower precision in results
longitude = -186.783333
longitude = -2186.783333
longitude = -23186.783333


//double of course has limits too
latitude = 326233312351.166667


//pre
var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

//convention is to prefer type inference over two line var setup
var missABeat = false


//operators

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var c = 1.1
var d = 2.2
var e = c + d

// for strings + appends
var namea = "Tim McGraw"
var nameb = "Romeo"
var both = namea + " and " + nameb


//modulous = &

var zero = 9 % 3
var one = 10 % 3


//comparisons
e > 3
e >= 3
e > 4
e < 4


stayOutTooLate
!stayOutTooLate

//double equals == is equality check
name == "Tim McGraw"

// != is inequality check
name != "Tim McGraw"


//string interpolation

"Your name is \(name)"

//using + is less efficient, and interpolation handles multiple data types
"Your name is \(name), your age is \(age), and your latitude is \(latitude)"

//interpolation also handles full expressions
"You are \(age) years old. In another \(age) years you will be \(age * 2)."


//arrays use type inference too

var evenNumbers = [2, 4, 6, 8]
var songs: [String] = ["Shake it Off", "You Belong with Me", "Back to December"]
var anything: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

songs[0]
songs[1]
songs[2]

type(of: songs)


var songs3: [String] = []
//this doesn't work - need to append
//songs3[0] = "Shake it Off"

var songsa = ["Shake it Off", "You Belong with Me", "Love Story"]
var songsb = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var joined = songsa + songsb
joined += ["Everything has Changed"]


var personArray = ["Taylor", "Alison", "Swift", "December", "taylorswift.com"]

var personDict = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]
personDict["middle"]
personDict["month"]


//conditionals
var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
} else if person == "player" {
    action = "play"
} else {
    action = "cruise"
}

// && for and ! for not

if stayOutTooLate && nothingInBrain {
    action = "cruise"
}

if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}

//loops

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

for _ in 1 ... 5 {
    str += " fake"
}

print(str)

for song in songs {
    print("My favorite song is \(song)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]
for i in 0 ... 3 {
    print("\(people[i]) gonna \(actions[i])")
}

for i in 0 ..< people.count {
    var str = "\(people[i]) gonna"
    
    for _ in 1 ... 5 {
        str += " \(actions[i])"
    }
    
    print(str)
}

var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 556 {
        break
    }
}

//continue jumps to next
for song in songs {
    if song == "You Belong with Me" {
        continue
    }
    
    print("My favorite song is \(song)")
}

//switch cases must be exhaustive

let liveAlbums = 2

switch liveAlbums {
case 0:
    print("You're just starting out")
    
case 1:
    print("You just released iTunes Live From SoHo")
    
case 2:
    print("You just released Speak Now World Tour")
    
default:
    print("Have you done something new?")
}

let studioAlbums = 5

switch studioAlbums {
case 0...1:
    print("You're just starting out")
    
case 2...3:
    print("You're a rising star")
    
case 4...5:
    print("You're world famous!")
    
default:
    print("Have you done something new?")
}
