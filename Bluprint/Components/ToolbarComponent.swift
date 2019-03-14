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
        toolbarManager?.undo()
        print("Toolbar: Undo")
    }
    @IBAction func redo(_ sender: UIButton) {
        print("Toolbar: Redo")
    }
    
    @IBAction func brush(_ sender: UIButton) {
        print("Toolbar: Brush")
        toolbarManager?.brush(button: sender)
//        let tableViewController = UITableViewController()
//        tableViewController.modalPresentationStyle = UIModalPresentationStyle.popover
//        tableViewController.preferredContentSize = CGSize(width: 400, height: 400)
//
//        present(tableViewController, animated: true, completion: nil)
//
//        let popoverPresentationController = tableViewController.popoverPresentationController
//        popoverPresentationController?.sourceView = sender
//        popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.size.width, height: sender.frame.size.height)

    }
    
    @IBAction func color(_ sender: UIButton) {
        print("Toolbar: Color")
        toolbarManager?.color(button: sender)
    }
    
    @IBAction func eraser(_ sender: UIButton) {
        print("Toolbar: Eraser")
    }
    
    @IBAction func deleteLayer(_ sender: UIButton) {
        toolbarManager?.deleteLayer()
        print("Toolbar: Delete layer")
    }
    
}
