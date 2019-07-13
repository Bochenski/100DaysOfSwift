//
//  ViewController.swift
//  Challenge1
//
//  Created by David Bochenski on 08/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            print(item)
            if item.hasSuffix("png") {
                //this is a flag to load
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        cell.textLabel?.text = String(flags[indexPath.row].prefix(flags[indexPath.row].count - 4))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedFlag = flags[indexPath.row]
            vc.selectedTitle = String(flags[indexPath.row].prefix(flags[indexPath.row].count - 4))
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

