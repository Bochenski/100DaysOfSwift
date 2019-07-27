//
//  ViewController.swift
//  Challenge03
//
//  Created by David Bochenski on 26/07/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var allWords = [String]()
    var guessedLetters = [Character]()
    var answer = ""
    var guessesLeft = 7
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForGuess))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame() {
        guessesLeft = 7
        guessedLetters.removeAll()
        if let randomWord = allWords.randomElement() {
            answer = randomWord
            refresh()
        }
    }
    
    func refresh() {
        var temp = ""
        var won = true
        for letter in answer {
            if guessedLetters.firstIndex(of: letter) != nil {
                temp.append(letter)
            }  else {
                temp += "?"
                won = false
            }
            title = temp + " Guesses remaining: \(guessesLeft)"
        }
        if won {
            let ac = UIAlertController(title: "You did it!", message: "The word is \(answer)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            startGame()
        }
    }

    @objc func promptForGuess() {
        let ac = UIAlertController(title: "Enter guess", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func submit(_ guess: String) {
        let lowerGuess = guess.lowercased()
        
        if !isSingleLetter(guess: lowerGuess) {
            showErrorMessage(title: "Steady on", message: "Guess just one letter at a time please!")
            return
        }
        
        if isAlreadyGuessed(guess: lowerGuess.first!) {
            showErrorMessage(title: "Pull up!", message: "You've already tried that letter!")
            return
        }
        guessedLetters.insert(lowerGuess.first!, at: 0)
        
        if !isInWord(guess: lowerGuess.first!) {

            guessesLeft -= 1
            if guessesLeft == 0 {
                showErrorMessage(title: "Game Over", message: "The word was \(answer).\n  Better Luck Next Time")
                startGame()
                
            }
            showErrorMessage(title: "nope!", message: "That's not in the word")
        }
        
        refresh()

    }

    func isSingleLetter(guess: String) -> Bool {
        return guess.count == 1
    }
    
    func isAlreadyGuessed(guess: Character) -> Bool {
        return guessedLetters.firstIndex(of: guess) != nil
    }
    
    func isInWord(guess: Character) -> Bool {
        return answer.firstIndex(of: guess) != nil
    }

}

