//
//  ViewController.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

private typealias Delegates = Home

class Home: UIViewController{
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var backgroundCanvas: UIImageView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var layersComponent: LayersComponent!
    
    var history: [UIImage] = []
    var layers: [Layer] = []
    var index = 0
    
    override func viewDidLoad() {
        print("Started")
        super.viewDidLoad()
        layers.append(Layer(name: "1"))
        canvasView.setup(delegate: self as HistoryManager)
        layersComponent.setup(layers: layers, delegate: self as LayerManager)
        canvasView.clearCanvas(animated:false)
    }
    
    @IBAction func newLayer(_ sender: UIButton) {
        newLayer()
        changeLayer(index: layers.count - 1)
    }
    
    @IBAction func revertLastAction(_ sender: UIButton) {
        if layers[index].history.count > 0 {
            canvasView.clearCanvas(animated:false)
            layers[index].history.removeLast()
            print("Removed last")
            drawCanvas(index: index)
        }
    }
    
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clearCanvas(animated: false)
    }
    
    func drawCanvas(index: Int){
        canvasView.image = layers[index].history.last
        
        backgroundCanvas.layer.sublayers = []
        for i in 0..<index {
            if let image = layers[i].history.last?.cgImage{
                let layer = CALayer()
                layer.frame = backgroundCanvas.bounds
                layer.contents = image
                layer.opacity = 0.5
                backgroundCanvas.layer.addSublayer(layer)
            }
        }
    }
}

extension Delegates: HistoryManager, LayerManager {
    func changeLayer(index: Int) {
        self.index = index
        print(self.index)
        drawCanvas(index: index)
    }
    
    func newLayer(){
        layers.append(Layer(name: (layers.count + 1).description))
        layersComponent.layers = layers.reversed()
        layersComponent.reloadData()
    }
    
    func appendActivity(newImage: UIImage) {
        layers[index].history.append(newImage)
    }
    
    
}


