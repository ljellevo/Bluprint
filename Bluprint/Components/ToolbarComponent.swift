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
    @IBOutlet weak var deleteLayer: UIButton!
    @IBOutlet weak var revertAction: UIButton!
    
    func setup(delegate: ToolbarManager){
        toolbarManager = delegate
    }
    
    @IBAction func deleteLayer(_ sender: UIButton) {
        toolbarManager?.deleteLayer()
        print("Delete layer")
    }
    
    @IBAction func revertAction(_ sender: UIButton) {
        toolbarManager?.revertAction()
        print("Revert")
    }
    
}
