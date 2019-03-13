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
    func deleteLayer()
    func undoAction()
}
