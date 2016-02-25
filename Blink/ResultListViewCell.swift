//
//  ResultListViewCell.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/24/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class ResultListViewCell: UITableViewCell {
    
    
    @IBOutlet var resultNumberLabel: UILabel!
    @IBOutlet var resultTextLabel: UILabel!
    @IBOutlet var resultValueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        resultTextLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        resultNumberLabel.font = caption1Font
        resultValueLabel.font = caption1Font
    }
}