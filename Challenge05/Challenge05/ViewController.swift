//
//  ViewController.swift
//  Challenge05
//
//  Created by David Bochenski on 21/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    var filteredCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let url = Bundle.main.url(forResource: "allCountries", withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            //we're ok to parse that data
            parse(json: data)
            return
        }
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
//        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
//            countries = jsonCountries.results
//            filteredCountries = countries
//            tableView.reloadData()
//        }
        do {
            let jsonCountries = try decoder.decode(Countries.self, from: json)
            countries = jsonCountries.results
            filteredCountries = countries
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = filteredCountries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = filteredCountries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

