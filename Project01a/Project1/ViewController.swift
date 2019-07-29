//
//  ViewController.swift
//  Project1
//
//  Created by David Bochenski on 01/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var storms = [Storm]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl") {
                    let storm = Storm(name: item, image: item)
                    //this is a picture to load
                    self?.storms.append(storm)
                }
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }

        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storms.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else {
            fatalError("Unable to dequeue a storm cell.")
        }
        let storm = storms[indexPath.item]
        cell.name.text = storm.name
        
        cell.imageView.image = UIImage(named: storm.image)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let storm = storms[indexPath.item]
            vc.selectedImage = storm.image
            vc.selectedTitle = "\(indexPath.item + 1) of \(storms.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
