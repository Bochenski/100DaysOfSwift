import UIKit


struct User {
    var username: String
}

var user = User(username: "twostraws")

// you can override the default initialiserw
struct AnonUser {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user2 = AnonUser()
user2.username = "twostraws"

//you can disambiguate the struct param from the func param using self.
struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

//Lazy properties are only initialised once used

struct FamilyTree {
    init() {
        print("Creating family tree")
    }
}

struct Person2 {
    var name: String
    var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var bob = Person2(name: "Bob")


struct LazyPerson {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var lazyBob = LazyPerson(name: "Bob")
lazyBob.familyTree

//statics are accessible through the struct type accessor

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(Student.classSize)

//marking a var private does what you'd expect - only accessible in the struct
struct Introvert {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My NI number is \(id)"
    }
}
