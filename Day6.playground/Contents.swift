let driving = {
    print("I'm driving in my car")
}

driving()

let drivingIn = { (place: String) in
    print("I'm going to \(place) in my car")
}

drivingIn("London")

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)


//you can also use trailing closure syntax
travel {
    print("I'm driving in my car")
}

//if there were other parameter you'd have done

travel () {
    print("I'm driving in my car")
}
