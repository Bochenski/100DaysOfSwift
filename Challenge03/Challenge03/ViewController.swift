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
    var usedWords = [String]()
    var guessedLetters = [String]()
    var answer = ""
    var answerLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.text = ""
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .right
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerLabel)
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

        ])
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
        answerLabel.text = ""
        if let answer = allWords.randomElement() {
            for _ in 1...answer.count {
                answerLabel.text! += "?"
            }
        }
        
    }

    @objc func promptForGuess() {

    }

    func guess(character: Character) {
//        for letter in answer {
//            if let position = answer.firstIndex(of: letter) {
//                tempWord.remove(at: position)
//            } else {
//                return false
//            }
//        }
    }
}

