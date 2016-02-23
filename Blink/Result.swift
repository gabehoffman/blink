//
//  Result.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/16/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import Foundation

struct Result {
    let text: String
    let id: Int
    let questionGrouping: [Int]
    
    init(text: String, id: Int, questionGrouping: [Int]) {
        self.text = text
        self.id = id
        self.questionGrouping = questionGrouping
    }
}