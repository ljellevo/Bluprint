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
    func appendActivity(newImage: UIImage)
}

protocol LayerManager: class {
    func newLayer()
    func changeLayer(index: Int)
}
