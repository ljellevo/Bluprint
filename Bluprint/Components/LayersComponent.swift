//
//  Layers.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

class LayersComponent: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var layerManager: LayerManager?
    var layers: [Layer] = []
    
    func setup(layers: [Layer], delegate: LayerManager){
        self.layers = layers
        self.layerManager = delegate
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "LayerCell", bundle: nil), forCellWithReuseIdentifier: "LayerCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayerCell", for: indexPath) as! LayerCell
        cell.layerLabel.text = layers[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        layerManager?.changeLayer(index: layers.count - indexPath.row - 1)
    }
}


