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
    let questionIDs: [Int]
    var rValues: [Int]
    
    init(text: String, id: Int, questionIDs: [Int], rValues: [Int]) {
        self.text = text
        self.id = id
        self.questionIDs = questionIDs
        self.rValues = rValues
    }
}