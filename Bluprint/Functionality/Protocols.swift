//
//  Protocols.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit

protocol HistoryManager: class{
    func appendAction(newImage: UIImage)
}

protocol LayerManager: class {
    func newLayer()
    func changeLayer(index: Int)
    func hideLayer(index: Int)
}

protocol ToolbarManager: class {
    func changedName(newName: String)
    func undo()
    func redo()
    func brush(button: UIButton)
    func color(button: UIButton)
    func deleteLayer()
}

protocol ColorManager: class {
    func colorChanged(color: UIColor)
    func documentColorAdded(color: UIColor)
}

protocol BrushManager: class {
    func brushChanged(to brush: Brushes)
    func thicknessChanged(to thickness: Int)
}

protocol ColorCellManager: class {
    func colorWasPicked(color: UIColor)
}
