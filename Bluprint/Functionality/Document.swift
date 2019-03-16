//
//  Document.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 16/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit

struct Document {
    var layers: [Layer] = []
    var recentColors: [UIColor] = []
    var documentColors: [UIColor] = []
    var brush: Brush = Brush(type: Brushes.pen, thickness: -1)
}
