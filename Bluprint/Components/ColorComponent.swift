//
//  ColorHistoryComponent.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 16/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit


class ColorComponent: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    var colors: [UIColor] = []
    weak var colorCellManager: ColorCellManager?
    
    func setup(delegate: ColorCellManager, colors: [UIColor]){
        colorCellManager = delegate
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "ColorCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
        self.colors = colors
        self.reloadData()
        print("Reload")
        print(colors.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        cell.colorView.backgroundColor = colors[indexPath.row]
        cell.colorView.layer.cornerRadius = 15
        cell.colorView.layer.borderWidth = 1
        cell.colorView.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colorCellManager?.colorWasPicked(color: colors[indexPath.row])
    }
}


