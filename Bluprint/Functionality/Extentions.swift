//
//  Extentions.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    func overlayed(with overlay: UIImage) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        overlay.draw(in: CGRect(origin: CGPoint.zero, size: size))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        return nil
    }
}

//class UIShortTapGestureRecognizer: UITapGestureRecognizer {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesBegan(touches, with: event)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) { [weak self] in
//            if self?.state != .recognized {
//                self?.state = .failed
//            }
//        }
//    }
//}
