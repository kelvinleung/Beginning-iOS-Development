//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by Kelvin Leung on 24/10/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        let red = CGFloat(Double(arc4random_uniform(255)) / 255)
        let green = CGFloat(Double(arc4random_uniform(255)) / 255)
        let blue = CGFloat(Double(arc4random_uniform(255)) / 255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

enum Shape: Int {
    case line = 0, rect, ellipse, image
}

enum DrawingColor: Int {
    case red = 0, blue, yellow, green, random
}

class QuartzFunView: UIView {

    var shape = Shape.line
    var currentColor = UIColor.red
    var useRandomColor = false
    
    private let image = UIImage(named: "iphone")
    private var firstTouchLocation = CGPoint.zero
    private var lastTouchLocation = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if useRandomColor {
                currentColor = UIColor.randomColor()
            }
            firstTouchLocation = touch.location(in: self)
            lastTouchLocation = firstTouchLocation
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(2)
        context.setStrokeColor(currentColor.cgColor)
        context.setFillColor(currentColor.cgColor)
        
        // A CGRect with a negative size will simply be rendered in the opposite direction of its origin point (to the left for a negative width; upward for a negative height)
        let currentRect = CGRect(origin: firstTouchLocation, size: CGSize(width: lastTouchLocation.x - firstTouchLocation.x, height: lastTouchLocation.y - firstTouchLocation.y))
        
        switch shape {
        case .line:
            context.move(to: firstTouchLocation)
            context.addLine(to: lastTouchLocation)
            context.strokePath()
        case .rect:
            context.addRect(currentRect)
            context.drawPath(using: .fillStroke)
        case .ellipse:
            context.addEllipse(in: currentRect)
            context.drawPath(using: .fillStroke)
        case .image:
            let horizontalOffset = image!.size.width / 2
            let verticalOffset = image!.size.height / 2
            let drawPoint = CGPoint(x: lastTouchLocation.x - horizontalOffset, y: lastTouchLocation.y - verticalOffset)
            image!.draw(at: drawPoint)
        }
    }

}
