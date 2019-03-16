//
//  ViewController.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

private typealias Delegates = Home
private typealias Toolbar = Home
private typealias Components = Home


class Home: UIViewController {
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var backgroundCanvas: UIImageView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var layersComponent: LayersComponent!
    @IBOutlet weak var toolbarContainer: UIView!
    
    var history: [UIImage] = []
    //var layers: [Layer] = []
    var document: Document = Document()
    var activeLayerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        document.layers.append(Layer(id: 1))
        canvasView.setup(delegate: self as HistoryManager)
        layersComponent.setup(layers: document.layers, delegate: self as LayerManager)
        canvasView.clearCanvas(animated:false)
        initToolbar()
        setToolbar(layer: document.layers[0])
    }
    
    @IBAction func newLayer(_ sender: UIButton) {
        newLayer()
        changeLayer(index: document.layers.count - 1)
    }
    
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clearCanvas(animated: false)
    }
    
    func drawCanvas(index: Int) {
        canvasView.image = document.layers[index].history.last
        
        backgroundCanvas.layer.sublayers = []
        for i in 0..<index {
            if let image = document.layers[i].history.last?.cgImage, document.layers[i].visible {
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

    func newLayer() {
        document.layers.append(Layer(id: (document.layers[document.layers.count - 1]).id + 1))
        layersComponent.layers = document.layers.reversed()
        layersComponent.reloadData()
    }
    
    func changeLayer(index: Int) {
        activeLayerIndex = index
        canvasView.setDrawColor(color: document.layers[activeLayerIndex].color)
        layersComponent.activeLayerIndex = document.layers.count - activeLayerIndex - 1
        layersComponent.reloadData()
        drawCanvas(index: index)
        setToolbar(layer: document.layers[activeLayerIndex])
    }
    
    func hideLayer(index: Int) {
        if document.layers[index].visible {
            document.layers[index].visible = false
        } else {
            document.layers[index].visible = true
        }
        layersComponent.layers = document.layers.reversed()
        layersComponent.reloadData()
        drawCanvas(index: activeLayerIndex)
    }
    
    func changedName(newName: String){
        document.layers[activeLayerIndex].name = newName
        layersComponent.layers = document.layers.reversed()
        layersComponent.reloadData()
        
    }
    
    func undo() {
        if document.layers[activeLayerIndex].history.count > 0 {
            canvasView.clearCanvas(animated:false)
            document.layers[activeLayerIndex].history.removeLast()
            drawCanvas(index: activeLayerIndex)
        }
    }
    
    func redo() {
        print("Home: Redo")
    }
    
    func brush(button: UIButton) {
        popoverModal(source: button, content: PopoverAction.brush)
    }
    
    func color(button: UIButton) {
        popoverModal(source: button, content: PopoverAction.color)
    }
    
    func deleteLayer() {
        let oldLayerIndex = activeLayerIndex
        if document.layers.count > 1 {
            document.layers.remove(at: oldLayerIndex)
            if activeLayerIndex == 0 {
                changeLayer(index: 0)
            } else {
                changeLayer(index: activeLayerIndex - 1)
            }
        }
        layersComponent.layers = document.layers.reversed()
        layersComponent.reloadData()
    }
    
    
    // History Manager
    func appendAction(newImage: UIImage) {
        document.layers[activeLayerIndex].history.append(newImage)
    }
}

extension Toolbar {
    
    func initToolbar() {
        let toolbar = Bundle.main.loadNibNamed("ToolbarComponent", owner: self, options: nil)!.first as! ToolbarComponent
        self.toolbarContainer.addSubview(toolbar)
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toolbar.translatesAutoresizingMaskIntoConstraints = true
        toolbar.frame = toolbarContainer.bounds
        toolbar.setup(delegate: self as ToolbarManager)
    }
    
    func setToolbar(layer: Layer) {
        let toolbar = toolbarContainer.subviews[0] as! ToolbarComponent
        if layer.name != "" {
            toolbar.name.text = layer.name
        } else {
            toolbar.name.text = ""
        }
        
        if document.layers.count > 1 {
            toolbar.deleteButton.isEnabled = true
        } else {
            toolbar.deleteButton.isEnabled = false
        }
    }
}

extension Components: UIPopoverPresentationControllerDelegate, BrushAndColorManager {
    
    func popoverModal(source: UIButton, content: PopoverAction) {
        switch content {
        case PopoverAction.brush:
            let ac = UIAlertController(title: "Hello!", message: "This is the brush popover.", preferredStyle: .actionSheet)
            let popover = ac.popoverPresentationController
            popover?.sourceView = source
            popover?.sourceRect = CGRect(x: 15, y: -15, width: 64, height: 64)
            present(ac, animated: true)
        case PopoverAction.color:
            let popover = Bundle.main.loadNibNamed("PopoverComponent", owner: self, options: nil)!.first as! PopoverComponent
            popover.modalPresentationStyle = .popover
            let popoverController = popover.popoverPresentationController
            popoverController?.delegate = self
            popoverController?.sourceView = source
            popoverController?.sourceRect = CGRect(x: 45, y: 45, width: 0, height: 0)
            popoverController?.permittedArrowDirections = [.down, .up]
            popover.preferredContentSize = CGSize(width: 250, height: 350)
            popover.load(delegate: self as BrushAndColorManager, document: document,  layer: document.layers[activeLayerIndex])
            present(popover, animated: true)
        }
    }
    
    func colorChanged(color: UIColor) {
        document.layers[activeLayerIndex].color = color
        document.recentColors.insert(color, at: 0)
        canvasView.setDrawColor(color: color)
    }
    
    func documentColorAdded(color: UIColor) {
        document.documentColors.insert(color, at: 0)
    }
    
    func brushChanged(brush: Brushes) {
        print("Home: Brush Changed")
    }
}




