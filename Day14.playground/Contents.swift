import UIKit

func favouriteAlbum() {
    print("My favorite is Fearless")
}

favouriteAlbum()

func favouriteAlbumIs(name: String) {
    print("My favorite is \(name)")
}

favouriteAlbumIs(name: "Fearless")

func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)
printAlbumRelease(name: "Speak Now", year: 2010)
printAlbumRelease(name: "Red", year: 2012)


//internal and external variable names
func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString(myString: "Hello")

//underscore for no external name

func countLettersIn(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersIn("Bob")


//better however to name everytning

func countLetters(in str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLetters(in: "Jack")


func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }
    
    return false
}

if albumIsTaylor(name: "Red") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}


//optionals

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

var status: String?
status = getHaterStatus(weather: "rainy")

//cannot call this with status, as it wants a string, not optional string = need to unwrap
func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}


//force unwrapping (risky = code crashes if you get this wrong)
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }
    
    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}

//implicitly unwrapped e.g. String! - swift won't check, but doesn't need unwrapping
var name: String! = "Sophie"

//optional chaining
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")


// nil coalescing
let album2 = albumReleased(year: 2006)?.uppercased() ?? "unknown"
print("The album is \(album2)")


//ENUMS

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType.wind(speed: 5))
getHaterStatus(weather: .cloud)


//structs

struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

print(taylor.clothes)
print(other.shoes)

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

//functions inside structs are called methods keyword still func
struct Person2 {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}


//Classes - no memberwise initialiser, could intro optionals, or defaults, or write your own init (latter most efficient)

// Swift requires that all non-optional properties have a value by the end of the initializer, or by the time the initializer calls any other method – whichever comes first.
class Person3 {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("La la la la")
    }
}

var taylors = Singer(name: "Taylor", age: 25)
taylors.name
taylors.age
taylors.sing()


//inheritanc
class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

var taylorc = CountrySinger(name: "Taylor", age: 25)
taylorc.sing()

class HeavyMetalSinger: Singer {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
    
    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}
