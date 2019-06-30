import UIKit

struct Person {
    var clothes: String {
        //property observers

        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
    
    var age: Int
    
    var ageInDogYears: Int {
        //if readonly like this you can remove the get {} and just have the implementation
        get {
            return age * 7
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts", shoes: "sneakers", age: 27)
let other = Person(clothes: "short skirts", shoes: "high heels", age: 36 )
taylor.describe()
other.describe()

taylor.clothes = "short skirts"
print(taylor.ageInDogYears)

//static properties
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"
    
    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)


//access control  public - any code, internal - only my code, fileprivate - only this file, private - only this type or its extensions


//polymorphism
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]


//downcasting - as? gives you an optional as! force unwraps (be careful)
for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}


let number = 5
//errors; let text = number as! String

let text = String(number)
print(text)

//this only works for some of swift inbuilt types

//closures
let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

//equivalently

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
