//
//  BrushComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 16/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

class BrushComponent: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate  {

    weak var brushManager: BrushManager?
    var brushes: [Brushes] = []
    
    func setup(delegate: BrushManager, brush: Brush, brushes: [Brushes]){
        brushManager = delegate
        self.brushes = brushes
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "BrushCell", bundle: nil), forCellWithReuseIdentifier: "BrushCell")
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brushes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrushCell", for: indexPath) as! BrushCell
        cell.frameView.layer.cornerRadius = cell.frame.width/2
        cell.frameView.layer.borderWidth = 1
        cell.frameView.layer.borderColor = UIColor.lightGray.cgColor
        switch indexPath.row {
        case 0:
            cell.cellText.text = "Pen"
        case 1:
            cell.cellText.text = "Pencil"
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            brushManager?.brushChanged(to: Brushes.pen)
        case 1:
            brushManager?.brushChanged(to: Brushes.pencil)
        default:
            break
        }
    }

}
