//
//  ViewController.swift
//  Challenge09
//
//  Created by David Bochenski on 17/09/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var picture: UIImage?
    var topText = ""
    var bottomText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickImage))
    }


    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        picture = image
        imageView.image = picture
        dismiss(animated: true)
      }
      
    
    func render() {
        guard let picture = picture else { return }
        let rect = CGRect(x: 0, y: 0, width: picture.size.width, height: picture.size.height)
        let renderer = UIGraphicsImageRenderer(size: picture.size)
        let image = renderer.image { ctx in
           
           let paragraphyStyle = NSMutableParagraphStyle()
           paragraphyStyle.alignment = .center
           
           picture.draw(in: rect)
       
           
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 128),
                .paragraphStyle: paragraphyStyle,
                .foregroundColor: UIColor.white
            ]
           


            let topAttributedString = NSAttributedString(string: topText, attributes: attrs)
            
            topAttributedString.draw(with: CGRect(x: 0, y: 0, width: picture.size.width, height: 512), options: .usesLineFragmentOrigin, context: nil)


            let bottomAttributedString = NSAttributedString(string: bottomText, attributes: attrs)
            
            bottomAttributedString.draw(with: CGRect(x: 0, y: picture.size.height - 150, width: picture.size.width, height: 512), options: .usesLineFragmentOrigin, context: nil)


        }
        imageView.image = image
        
    }
    
    @IBAction func topText(_ sender: Any) {
        let ac = UIAlertController(title: "Top Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.topText = text
            self?.render()

        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    @IBAction func bottomText(_ sender: Any) {
        let ac = UIAlertController(title: "Bottom Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.bottomText = text
            self?.render()

        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    @IBAction func share(_ sender: Any) {
    }
}

