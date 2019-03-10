//
//  ViewController.swift
//  Bluprint
//
//  Created by Ludvig Ellevold on 10/03/2019.
//  Copyright © 2019 Ludvig Ellevold. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        print("Started")
        super.viewDidLoad()
        canvasView.clearCanvas(animated:false)
    }
    
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clearCanvas(animated: false)
    }
    

}

