//
//  ToolbarComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 11/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit

private typealias Textfield = ToolbarComponent


class ToolbarComponent: UIView {
    
    weak var toolbarManager: ToolbarManager?
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    func setup(delegate: ToolbarManager){
        toolbarManager = delegate
        name.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func undo(_ sender: UIButton) {
        toolbarManager?.undo()
    }
    
    @IBAction func redo(_ sender: UIButton) {
        print("Toolbar: Redo")
    }
    
    @IBAction func brush(_ sender: UIButton) {
        toolbarManager?.brush(button: sender)
    }
    
    @IBAction func color(_ sender: UIButton) {
        toolbarManager?.color(button: sender)
    }
    
    @IBAction func eraser(_ sender: UIButton) {
        print("Toolbar: Eraser")
    }
    
    @IBAction func deleteLayer(_ sender: UIButton) {
        toolbarManager?.deleteLayer()
    }
}

extension Textfield {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let newName = name.text {
            toolbarManager?.changedName(newName: newName)
        }
    }
}


