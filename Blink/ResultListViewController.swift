//
//  ResultListViewController.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/24/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Freddy

class ResultListViewController: UITableViewController, BlinkModelLoadable {
    
    var dataURL: NSURL?
    var blink: BlinkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBlinkModel()
    }
    
    func loadBlinkModel() {
        if let data = getDataFromFileURL(self.dataURL) {
            blink = BlinkModel(data: data)
        } else {
            presentError("Could not load data file.")
        }
    }
    
}

extension ResultListViewController { // UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blink.results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Result", forIndexPath: indexPath) as! ResultListViewCell
        
        // Update the labels for the new preferred text size
        cell.updateLabels()
        
        // Get the questions for the item that is at the nth index of items, where n = row this cell will appear in on the tableview
        let result = self.blink.results[indexPath.row]
        
        // Configure the cell with the question.info
        cell.resultTextLabel?.text = "\(result.text)"
        cell.resultNumberLabel?.text = "\(result.id))"
        cell.resultValueLabel?.text = "\(result.rValues)"
        return cell
    }
    
}
