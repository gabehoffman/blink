//
//  BlinkModel.swift
//  BlinkModel
//
//  Created by Gabe Hoffman on 2/5/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class BlinkModel {
    
    var questions: [String] = []
    var answers: [Int] = []
    let xAxis: String
    let yAxis: String
    var currentQuestionIndex = 0
    var currentQuestion: String {
        return questions[currentQuestionIndex]
    }
    var currentAnswer: Int {
        return answers[currentQuestionIndex]
    }
    var nextQuestion: String {
        return questions[self.nextIndex()]
    }
    var nextAnswer: Int {
        return answers[self.nextIndex()]
    }
    var previousQuestion: String {
        return questions[self.previousIndex()]
    }
    var previousAnswer: Int {
        return answers[self.previousIndex()]
    }
    
    init() {
        xAxis = "Group"
        yAxis = "Individual"
        
        for i in 1...6 {
            questions.append("\(xAxis) Question \(i)- How do you rate yourself in regard to this area?")
            answers.append(5)
            
            questions.append("\(yAxis) Question \(i)- How do you rate yourself in regard to this area?")
            answers.append(5)
        }
    
    }
    
    func nextIndex() -> Int {
        // Go to the next question or return to the beginning
        var questionIndex = currentQuestionIndex + 1
        if questionIndex == questions.count {
            // Loop back to the begining
            questionIndex = 0
            return questionIndex
        } else {
            // return next question
            return questionIndex
        }
    }
    
    func previousIndex() -> Int {
        // Go to the next question or return to the beginning
        var questionIndex = currentQuestionIndex - 1
        if questionIndex < 0 {
            // Loop back to the end
            questionIndex = questions.count - 1
            return questionIndex
        } else {
            // return previous question
            return questionIndex
        }
        
    }
    
    func next() -> Int {
        // Go to the next question or return to the beginning
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            // Loop back to the begining
            currentQuestionIndex = 0
            return currentQuestionIndex
        } else {
            // return next question
            return currentQuestionIndex
        }
    }
    
    func previous() -> Int {
        // Go to the next question or return to the beginning
        currentQuestionIndex -= 1
        if currentQuestionIndex < 0 {
            // Loop back to the end
            currentQuestionIndex = questions.count - 1
            return currentQuestionIndex
        } else {
            // return previous question
            return currentQuestionIndex
        }
    }
}
