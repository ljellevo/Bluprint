//
//  ViewController.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

private typealias Delegates = Home
private typealias Components = Home

class Home: UIViewController{
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var backgroundCanvas: UIImageView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var layersComponent: LayersComponent!
    @IBOutlet weak var toolbarContainer: UIView!
    
    var history: [UIImage] = []
    var layers: [Layer] = []
    var activeLayerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layers.append(Layer(id: 1))
        canvasView.setup(delegate: self as HistoryManager)
        layersComponent.setup(layers: layers, delegate: self as LayerManager)
        canvasView.clearCanvas(animated:false)
        addToolbarComponent()
        setToolbar(layer: layers[0])
    }
    
    func setToolbar(layer: Layer){
        let toolbar = toolbarContainer.subviews[0] as! ToolbarComponent
        if layer.name != "" {
            toolbar.layerName.text = layer.name
        } else {
            toolbar.layerName.text = layer.id.description
        }
        
        if layers.count > 1 {
            toolbar.deleteLayer.isEnabled = true
        } else {
            toolbar.deleteLayer.isEnabled = false
        }
    }
    
    @IBAction func newLayer(_ sender: UIButton) {
        newLayer()
        changeLayer(index: layers.count - 1)
    }
    
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clearCanvas(animated: false)
    }
    
    func drawCanvas(index: Int){
        canvasView.image = layers[index].history.last
        
        backgroundCanvas.layer.sublayers = []
        for i in 0..<index {
            if let image = layers[i].history.last?.cgImage, layers[i].visible {
                let layer = CALayer()
                layer.frame = backgroundCanvas.bounds
                layer.contents = image
                layer.opacity = 0.5
                backgroundCanvas.layer.addSublayer(layer)
            }
        }
    }
}

extension Delegates: HistoryManager, LayerManager, ToolbarManager {

    func newLayer(){
        layers.append(Layer(id: (layers[layers.count - 1]).id + 1))
        layersComponent.layers = layers.reversed()
        layersComponent.reloadData()
    }
    
    func changeLayer(index: Int) {
        activeLayerIndex = index
        drawCanvas(index: index)
        setToolbar(layer: layers[activeLayerIndex])
    }
    
    func hideLayer(index: Int) {
        layers[index].visible = false
        drawCanvas(index: activeLayerIndex)
        print("Hide")
    }
    
    
    func deleteLayer() {
        let oldLayerIndex = activeLayerIndex
        if layers.count > 1 {
            layers.remove(at: oldLayerIndex)
            if activeLayerIndex == 0 {
                changeLayer(index: 0)
            } else {
                changeLayer(index: activeLayerIndex - 1)
            }
        }
        layersComponent.layers = layers.reversed()
        layersComponent.reloadData()
    }
    
    func revertAction() {
        if layers[activeLayerIndex].history.count > 0 {
            canvasView.clearCanvas(animated:false)
            layers[activeLayerIndex].history.removeLast()
            print("Removed last")
            drawCanvas(index: activeLayerIndex)
        }
    }
    
    // History Manager
    func appendActivity(newImage: UIImage) {
        layers[activeLayerIndex].history.append(newImage)
    }
}

extension Components {
    func addToolbarComponent(){
        let toolbar = Bundle.main.loadNibNamed("ToolbarComponent", owner: self, options: nil)!.first as! ToolbarComponent
        self.toolbarContainer.addSubview(toolbar)
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toolbar.translatesAutoresizingMaskIntoConstraints = true
        toolbar.frame = toolbarContainer.bounds
        toolbar.setup(delegate: self as ToolbarManager)
    }
}


