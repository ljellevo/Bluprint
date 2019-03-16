//
//  BrushPopover.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 16/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

private typealias Delegate = BrushPopover

class BrushPopover: UIViewController {
    
    weak var brushManager: BrushManager?

    @IBOutlet weak var brushComponent: BrushComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func load(delegate: BrushManager, brush: Brush, brushes:[Brushes]) {
        brushManager = delegate
        brushComponent.setup(delegate: self as BrushManager, brush: brush, brushes: brushes)
        brushComponent.reloadData()
    }
}

extension Delegate: BrushManager {
    func brushChanged(to brush: Int) {
        brushManager?.brushChanged(to: brush)
    }
}
