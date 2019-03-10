//
//  Layers.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

class Layers: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setup(){
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "LayerCell", bundle: nil), forCellWithReuseIdentifier: "LayerCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayerCell", for: indexPath) as! LayerCell
        return cell
    }
}
