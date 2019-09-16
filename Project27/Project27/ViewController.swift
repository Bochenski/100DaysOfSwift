//
//  ViewController.swift
//  Project27
//
//  Created by David Bochenski on 15/09/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 6 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        default:
            break
        }
        
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
      
        }
        
        imageView.image = image
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 206, y: 206, width: 50, height: 50)
            

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(1)
            
            ctx.cgContext.addEllipse(in: rectangle)


            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
//
            
            ctx.cgContext.move(to: CGPoint(x: 220, y: 235))
            ctx.cgContext.addQuadCurve(to: CGPoint(x: 242, y: 235), control: CGPoint(x:231, y: 260))
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let leftEye = CGRect(x: 218, y: 225, width: 5, height: 5)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.drawPath(using: .fillStroke)

            let rightEye = CGRect(x: 240, y: 225, width: 5, height: 5)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let xStart = 100
            let yTop = 50
            let yBottom = yTop + 50
            
            let width = 26
            
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            
            //t
            ctx.cgContext.move(to: CGPoint(x: xStart, y: yTop))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 2, y: yTop))
            ctx.cgContext.move(to: CGPoint(x: xStart + width, y: yTop))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width, y: yBottom))
            
            //w
            ctx.cgContext.move(to: CGPoint(x: xStart + width * 3, y: yTop))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 4, y: yBottom))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 4 + 13, y: yBottom - 10))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 5, y: yBottom))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 6, y: yTop))
            
            //I
            ctx.cgContext.move(to: CGPoint(x: xStart + width * 7, y: yTop))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 7, y: yBottom))
            
            //N
            ctx.cgContext.move(to: CGPoint(x: xStart + width * 8, y: yBottom))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 8, y: yTop))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 9, y: yBottom))
            ctx.cgContext.addLine(to: CGPoint(x: xStart + width * 9, y: yTop))
            
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            

        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                if first {
                    first = false
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let paragraphyStyle = NSMutableParagraphStyle()
            paragraphyStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphyStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y:150))
        }
        
        imageView.image = image
    }
}

