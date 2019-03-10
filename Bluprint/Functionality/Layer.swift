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
    var name: String = ""
    var history: [UIImage] = []
    
    init(name: String) {
        self.name = name
    }

}
