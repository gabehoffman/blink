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
    let weight: Int
    
    init(text: String, answer: Int, id: Int, weight: Int) {
        self.text = text
        self.answer = answer
        self.id = id
        self.weight = 1
    }
}