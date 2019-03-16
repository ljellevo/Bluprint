//
//  Layer.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit

struct Layer {
    var id: Int = -1
    var name: String = ""
    var history: [UIImage] = []
    var visible: Bool = true
    var color: UIColor = UIColor.black
    var brush: Brushes = Brushes.pen
    var brushThickness: Int = -1
    
    init(id: Int) {
        self.id = id
    }

}
