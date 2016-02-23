//
//  QuestionListViewController.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/13/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Freddy

class QuestionListViewController: UITableViewController, DataURLLoadable {
    
    var dataURL: NSURL?
    var blink: BlinkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBlinkModel()
    }
    
    private func loadBlinkModel() {
        if let data = getDataFromFileURL(self.dataURL) {
            do {
                let json = try JSON(data: data)
                blink = BlinkModel(data: data)
            } catch {
                presentError(error)
            }
        } else {
            presentError("Could not load data file.")
        }
    }
    
}

extension QuestionListViewController { // UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blink.questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Question", forIndexPath: indexPath) as! QuestionListViewCell
        
        // Update the labels for the new preferred text size
        cell.updateLabels()
        
        // Get the questions for the item that is at the nth index of items, where n = row this cell will appear in on the tableview
        let question = self.blink.questions[indexPath.row]
        
        // Configure the cell with the question.info
        cell.questionTextLabel?.text = "\(question.text)"
        cell.questionNumberLabel?.text = "\(question.id))"
        cell.questionValueLabel?.text = "[\(question.answer)]"
        return cell
    }
    
}
