import UIKit

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let quotient = firstScore / secondScore
let modulus = 13 % secondScore

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

var score = 95
score -= 5

var quote = "The rain in Spain fall mainly on the "
quote += "Spaniards"

let firstScore2 = 6
let secondScore2 = 4

firstScore2 == secondScore2
firstScore2 != secondScore2

firstScore2 < secondScore2

firstScore2 >= secondScore2

"Taylor" <= "Swift"

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular Cards")
}

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}
//ternary operator

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

//Switch statements
let weather = "sunny"
switch weather {
    case "rain":
        print("Bring an umbrella")
    case "snow":
    print("Wrap up warm")
    case "sunny":
    print("Wear sunscreen")
    fallthrough
    default: 
    print("Enjoy your day!")
}

//range operators

let score2 = 85

switch score2 {
    case 0..<50:
    print("You failed badly.")
    case 50...85:
    print("You did OK.")
    default:
    print("You did great!")
}
