//
//  LayerCell.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

class LayerCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var layerLabel: UILabel!
    @IBOutlet weak var layerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.view.layer.cornerRadius = 5.0
    }
}
