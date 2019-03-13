//
//  CustomGestureRecognizers.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 14/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

class UIShortTapGestureRecognizer: UITapGestureRecognizer {
    let waitDuration: Double = 0.2
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration) { [weak self] in
            if self?.state != UIGestureRecognizer.State.recognized {
                self?.state = UIGestureRecognizer.State.failed
            }
        }
    }
}
