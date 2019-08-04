//
//  DetailViewController.swift
//  Challenge04
//
//  Created by David Bochenski on 04/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: URL?
    var selectedTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedTitle
        navigationItem.largeTitleDisplayMode = .never
       
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(contentsOfFile: imageToLoad.path)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
