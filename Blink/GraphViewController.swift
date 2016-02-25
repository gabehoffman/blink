//
//  GraphViewController.swift
//  Blink
//
//  Created by Gabe at Work on 2/25/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, DataURLLoadable {
    
    var dataURL: NSURL?
    @IBOutlet weak var radarChartView: RadarChartView!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
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
        let chartData = RadarChartData(xVals: months, dataSet: chartDataSet)
        radarChartView.data = chartData
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        radarChartView.xAxis.labelPosition = .Bottom
        radarChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.5)
        radarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
}