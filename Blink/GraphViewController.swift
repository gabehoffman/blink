//
//  GraphViewController.swift
//  Blink
//
//  Created by Gabe at Work on 2/25/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, BlinkModelLoadable {
    
    var dataURL: NSURL?
    var blink: BlinkModel!
    @IBOutlet weak var radarChartView: RadarChartView!
    
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
        radarChartView.noDataText = "You need to provide data for the chart."
        radarChartView.descriptionText = ""
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = RadarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = RadarChartData(xVals: chartAxis, dataSet: chartDataSet)
        radarChartView.data = chartData
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        radarChartView.xAxis.labelPosition = .Bottom
        radarChartView.xAxis.drawGridLinesEnabled = false
        radarChartView.yAxis.drawGridLinesEnabled = true
        radarChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.5)
        radarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
}