//
//  PopoverComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 14/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit
import ChromaColorPicker

class PopoverComponent: UIViewController, ChromaColorPickerDelegate {
    
    weak var brushAndColorManager: BrushAndColorManager?
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var recentColorsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = UIColor.white
    }

    func load(delegate: BrushAndColorManager, color: UIColor){
        brushAndColorManager = delegate
        let colorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        colorPicker.delegate = self
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.hexLabel.textColor = UIColor.black
        colorPicker.currentAngle = Float.pi
        colorPicker.supportsShadesOfGray = true
        colorPicker.addTarget(self, action: #selector(editingComplete(_ :)), for: .editingDidEnd)
        colorPicker.adjustToColor(color)
        colorView.addSubview(colorPicker)
    }
    
    
    @objc func editingComplete(_ sender: Any) {
        let subview = colorView.subviews.filter{$0 is ChromaColorPicker}.first
        let colorPicker = subview as! ChromaColorPicker
        brushAndColorManager?.colorChanged(color: colorPicker.currentColor)
        
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        //Set as document color
        brushAndColorManager?.colorChanged(color: color)
    }
}
