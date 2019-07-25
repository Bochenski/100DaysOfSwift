//
//  ViewController.swift
//  Project09
//
//  Created by David Bochenski on 18/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
   @objc func fetchJSON() {
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
    
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                //we're ok to parse that data
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filter =  UIBarButtonItem(barButtonSystemItem: .search , target: self, action: #selector(enterFilter))
        
        let reset =  UIBarButtonItem(barButtonSystemItem: .refresh , target: self, action: #selector(resetFilter))
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(showCredits))

        navigationItem.leftBarButtonItems = [filter, reset]
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default)
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    @objc func enterFilter() {
        let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filterOn(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    @objc func resetFilter() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    @objc func filterOn(_ term: String) {
        if term == "" { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.filteredPetitions.removeAll(keepingCapacity: true)
            guard let pets = self?.petitions else { return }
            for petition in pets {
                if petition.title.lowercased().contains(term.lowercased()) {
                    self?.filteredPetitions.append(petition)
                }
            }
            
            self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }

    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
   
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}
