//
//  Layers.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

private typealias GestureManager = LayersComponent

class LayersComponent: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var layerManager: LayerManager?
    var layers: [Layer] = []
    
    
    
    func setup(layers: [Layer], delegate: LayerManager){
        self.layers = layers
        self.layerManager = delegate
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "LayerCell", bundle: nil), forCellWithReuseIdentifier: "LayerCell")
        addGestureRecognizers()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayerCell", for: indexPath) as! LayerCell
        if layers[indexPath.row].name != "" {
            cell.layerLabel.text = layers[indexPath.row].name
        } else {
            cell.layerLabel.text = layers[indexPath.row].id.description
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //layerManager?.changeLayer(index: layers.count - indexPath.row - 1)
    }
}

extension GestureManager {
    
    func addGestureRecognizers() {
        let singleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSingleTapCollectionView(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture: UIShortTapGestureRecognizer = UIShortTapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func didSingleTapCollectionView(_ gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self)
        if let indexPath: IndexPath = self.indexPathForItem(at: pointInCollectionView){
            let _: UICollectionViewCell = self.cellForItem(at: indexPath as IndexPath)!
            layerManager?.changeLayer(index: layers.count - indexPath.row - 1)
        }
        
    }
    
    @objc func didDoubleTapCollectionView(_ gesture: UIShortTapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self)
        if let indexPath: IndexPath = self.indexPathForItem(at: pointInCollectionView){
            let _: UICollectionViewCell = self.cellForItem(at: indexPath as IndexPath)!
            layerManager?.hideLayer(index: layers.count - 1 - indexPath.row)
        }
        
    }
    
    
}


