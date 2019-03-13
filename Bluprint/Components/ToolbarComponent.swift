//
//  ToolbarComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 11/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit

class ToolbarComponent: UIView {
    
    weak var toolbarManager: ToolbarManager?
    
    @IBOutlet weak var layerName: UILabel!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    func setup(delegate: ToolbarManager){
        toolbarManager = delegate
    }
    
    
    @IBAction func undo(_ sender: UIButton) {
        toolbarManager?.undoAction()
        print("Toolbar: Undo")
    }
    @IBAction func redo(_ sender: UIButton) {
        print("Toolbar: Redo")
    }
    
    @IBAction func brush(_ sender: UIButton) {
        print("Toolbar: Brush")
    }
    
    @IBAction func color(_ sender: UIButton) {
        print("Toolbar: Color")
    }
    
    @IBAction func eraser(_ sender: UIButton) {
        print("Toolbar: Eraser")
    }
    
    @IBAction func deleteLayer(_ sender: UIButton) {
        toolbarManager?.deleteLayer()
        print("Toolbar: Delete layer")
    }
    
}
