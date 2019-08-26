//
//  DetailViewController.swift
//  Challenge05
//
//  Created by David Bochenski on 26/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var detailItem: Country?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = detailItem?.name
        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath)
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = detailItem?.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Capital", for: indexPath)
            cell.textLabel?.text = "Capital"
            cell.detailTextLabel?.text = detailItem?.capital
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Population", for: indexPath)
            cell.textLabel?.text = "Population"
            if let pop = detailItem?.population
            {
                cell.detailTextLabel?.text = String(pop)
            } else {
                cell.detailTextLabel?.text = "N/A"
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Area", for: indexPath)
            cell.textLabel?.text = "Area"
            if let area = detailItem?.area
            {
                cell.detailTextLabel?.text = String(area)
            } else {
                cell.detailTextLabel?.text = "N/A"
            }
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath)
        }

        

    }
}
