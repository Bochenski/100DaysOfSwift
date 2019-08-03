//
//  ViewController.swift
//  Project05
//
//  Created by David Bochenski on 12/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
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
    
    @objc func restartGame() {
        let defaults = UserDefaults.standard
        usedWords.removeAll(keepingCapacity: true)
        defaults.set(nil, forKey: "currentWord")
        defaults.set(usedWords, forKey: "usedWords")
        startGame()
    }
   
    func startGame() {
        let defaults = UserDefaults.standard
        if let word = defaults.string(forKey: "currentWord") {
            title = word
            usedWords = defaults.stringArray(forKey: "usedWords") ?? [String]()
        } else {
            title = allWords.randomElement()
            defaults.set(title, forKey: "currentWord")
        }


        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        if !isPossible(word: lowerAnswer) {
            showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }
        
        if !isLongEnough(word: lowerAnswer) {
            showErrorMessage(title: "Words must be at least 4 characters", message: "Try harder!")
            return
        }
        
        if isStartWord(word: lowerAnswer) {
            showErrorMessage(title: "Nice try", message: "can't be the word you start with")
            return
        }
        
        if !isOriginal(word: lowerAnswer) {
            showErrorMessage(title: "Word already used", message: "Be more original!")
            return
        }
        
        if !isReal(word: lowerAnswer) {
            guard let title = title else { return }
            showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title.lowercased())")
            return
        }
        
        usedWords.insert(answer.lowercased(), at: 0)
        let defaults = UserDefaults.standard
        defaults.set(usedWords, forKey: "usedWords")
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)

    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isStartWord(word: String) -> Bool {
        guard let tempWord = title?.lowercased() else { return false }
        return word.lowercased() == tempWord
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count > 2
    }
    
    func isReal(word: String) -> Bool {

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

