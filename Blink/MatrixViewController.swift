//
//  MatrixViewController.swift
//  Blink
//
//  Created by Gabe at Work on 2/26/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

//
//  GraphViewController.swift
//  Blink
//
//  Created by Gabe at Work on 2/25/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Charts

class MatrixViewController: UIViewController, BlinkModelLoadable {
    
    var dataURL: NSURL?
    var blink: BlinkModel!
    @IBOutlet weak var matrixView: MatrixView!
    
    var chartAxis: [String] = []
    var values: [Double] = []
    
    func loadBlinkModel() {
        if let data = getDataFromFileURL(self.dataURL) {
            blink = BlinkModel(data: data)
        } else {
            presentError("Could not load data file.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBlinkModel()
        
        for i in blink.axis {
            chartAxis.append(i.label)
        }
        
        for i in blink.results {
            values.append(Double( i.rValues.first! ) )
        }
        
        setChart(chartAxis , values: values)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        matrixView.graph = blink.graph
        
    }
}