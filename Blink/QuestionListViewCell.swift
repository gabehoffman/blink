//
//  QuestionListViewCell.swift
//  Blink
//
//  Created by Gabe Remote Office on 2/23/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class QuestionListViewCell: UITableViewCell {
    
    
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var questionTextLabel: UILabel!
    @IBOutlet var questionValueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        questionTextLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        questionNumberLabel.font = caption1Font
        questionValueLabel.font = caption1Font
    }
}
