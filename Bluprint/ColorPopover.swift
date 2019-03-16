//
//  PopoverComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 14/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit
import ChromaColorPicker

private typealias ColorDelegate = ColorPopover
private typealias Gesture = ColorPopover


class ColorPopover: UIViewController, ChromaColorPickerDelegate {
    
    var recentColors: [UIColor] = []
    var documentColors: [UIColor] = []
    weak var brushAndColorManager: ColorManager?
    var longPressDone = false
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var recentColorsView: UIView!
    @IBOutlet weak var recentColorsComponent: ColorComponent!
    @IBOutlet weak var documentColorsComponent: ColorComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = UIColor.white
        recentColorsView.backgroundColor = UIColor.white
    }
    

    func load(delegate: ColorManager, document: Document, layer: Layer) {
        brushAndColorManager = delegate
        let colorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        colorPicker.delegate = self
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.hexLabel.textColor = UIColor.black
        colorPicker.currentAngle = Float.pi
        colorPicker.supportsShadesOfGray = true
        colorPicker.addTarget(self, action: #selector(editingComplete(_ :)), for: .editingDidEnd)
        colorPicker.adjustToColor(layer.color)
        colorPicker.handleLine.strokeColor = UIColor.lightGray.cgColor
        colorView.addSubview(colorPicker)
        
        initColorViews(document: document)
    }
    
    func initColorViews(document: Document) {
        recentColors = document.recentColors
        documentColors = document.documentColors
        recentColorsComponent.setup(delegate: self as ColorCellManager, colors: recentColors)
        documentColorsComponent.setup(delegate: self as ColorCellManager, colors: documentColors)
        addLongPressGesture(for: documentColorsComponent)
    }
    
    
    @objc func editingComplete(_ sender: Any) {
        let subview = colorView.subviews.filter{$0 is ChromaColorPicker}.first
        let colorPicker = subview as! ChromaColorPicker
        brushAndColorManager?.colorChanged(color: colorPicker.currentColor)
        recentColors.put(color: colorPicker.currentColor)
        updateColor(in: recentColorsComponent, colors: recentColors)
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        //Set as document color
        brushAndColorManager?.documentColorAdded(color: color)
        documentColors.put(color: colorPicker.currentColor)
        updateColor(in: documentColorsComponent, colors: documentColors)
    }
    
    func updateColor(in view: ColorComponent, colors: [UIColor]){
        view.colors = colors
        view.reloadData()
    }
}

extension ColorDelegate: ColorCellManager {

    func colorWasPicked(color: UIColor) {
        let subview = colorView.subviews.filter{$0 is ChromaColorPicker}.first
        let colorPicker = subview as! ChromaColorPicker
        colorPicker.adjustToColor(color)
        brushAndColorManager?.colorChanged(color: colorPicker.currentColor)
        recentColors.put(color: colorPicker.currentColor)
        updateColor(in: recentColorsComponent, colors: recentColors)
    }
}

extension Gesture: UIGestureRecognizerDelegate {
    func addLongPressGesture(for view: ColorComponent) {
        let gesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_ :)))
        gesture.minimumPressDuration = 1.0
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc func handleLongPress(_ gestureRecognizer : UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            longPressDone = false
            
        }

        if !longPressDone {
            let pointInCollectionView: CGPoint = gestureRecognizer.location(in: documentColorsComponent)
            if let indexPath: IndexPath = documentColorsComponent.indexPathForItem(at: pointInCollectionView) {
                documentColors.remove(at: indexPath.row)
                updateColor(in: documentColorsComponent, colors: documentColors)
                longPressDone = true
            }
        }
    }
}
