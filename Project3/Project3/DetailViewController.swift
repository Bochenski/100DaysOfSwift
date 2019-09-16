//
//  DetailViewController.swift
//  Project1
//
//  Created by David Bochenski on 02/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedTitle
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .action, target: self,
                         action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {

            if let picture = UIImage(named: imageToLoad) {
                let rectangle = CGRect(x: 0, y: 0, width: picture.size.width, height: picture.size.height)
                let renderer = UIGraphicsImageRenderer(size: picture.size)
                let image = renderer.image { ctx in
                    
                    let paragraphyStyle = NSMutableParagraphStyle()
                    paragraphyStyle.alignment = .center
                    
                    picture.draw(in: rectangle)
                
                    
                     let attrs: [NSAttributedString.Key: Any] = [
                         .font: UIFont.systemFont(ofSize: 36),
                         .paragraphStyle: paragraphyStyle
                     ]
                    
                    let string = "From Storm Viewer"
                    
                    let attributedString = NSAttributedString(string: string, attributes: attrs)
                    
                    attributedString.draw(with: CGRect(x: 290, y: 64, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
                }
                
                imageView.image = image
            }
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
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [selectedImage!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
