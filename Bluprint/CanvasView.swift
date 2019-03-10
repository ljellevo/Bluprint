//
//  CanvasView.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

let π = CGFloat(Double.pi)

class CanvasView: UIImageView {
    
    // Parameters
    private let defaultLineWidth:CGFloat = 6
    private let forceSensitivity: CGFloat = 4.0
    
    private var drawColor: UIColor = UIColor.red
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch")
        guard let touch = touches.first else { return }
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // Draw previous image into context
        image?.draw(in: bounds)
        
        drawStroke(context: context, touch: touch)
        
        // Update image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func drawStroke(context: CGContext?, touch: UITouch) {
        print("Drawing")
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        // Calculate line width for drawing stroke
        let lineWidth = lineWidthForDrawing(context: context, touch: touch)
        
        // Set color
        drawColor.setStroke()
        
        // Configure line
        context!.setLineWidth(lineWidth)
        context!.setLineCap(.round)
        
        
        // Set up the points
        context!.move(to: previousLocation)
        context!.addLine(to: location)
        // Draw the stroke
        context!.strokePath()
        
    }
    
    private func lineWidthForDrawing(context: CGContext?, touch: UITouch) -> CGFloat {
        print("Line width")
        var lineWidth = defaultLineWidth
        if touch.force > 0 {
            lineWidth = touch.force * forceSensitivity
        }
        return lineWidth
    }
    
    func clearCanvas(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.alpha = 1
                self.image = nil
            })
        } else {
            image = nil
        }
    }
}

