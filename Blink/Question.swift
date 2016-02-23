//
//  Question.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/16/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    var answer: Int
    let id: Int
    let defaultValue: Int
    let weight: Int
    
    init(text: String, answer: Int, id: Int, defaultValue: Int, weight: Int) {
        self.text = text
        self.answer = answer
        self.id = id
        self.defaultValue = defaultValue
        self.weight = 1
    }
}