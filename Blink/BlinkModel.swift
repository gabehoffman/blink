//
//  BlinkModel.swift
//  BlinkModel
//
//  Created by Gabe Hoffman on 2/5/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Freddy

class BlinkModel {
    
    var title: String
    var type: Shape
    var questions: [Question] = []
    var results: [Result] = []
    var axis: [Axis] = []
    var graph: Graph?
    
    var currentQuestionIndex = 0
    var currentQuestion: String {
        return questions[currentQuestionIndex].text
    }
    var currentAnswer: Int {
        return questions[currentQuestionIndex].answer
    }
    var nextQuestion: String {
        return questions[self.nextIndex()].text
    }
    var nextAnswer: Int {
        return questions[self.nextIndex()].answer
    }
    var previousQuestion: String {
        return questions[self.previousIndex()].text
    }
    var previousAnswer: Int {
        return questions[self.previousIndex()].answer
    }
    
    init(data: NSData) {
        do {
            let json = try JSON(data: data)
            let success = try json.bool("success")
            print(success)
            self.title = try json.string("quiz","title")
            print(title)
            let shape = try json.string("quiz","type")
            self.type = Graph.makeShape(shape)
            print(type)
            self.questions = try json.array("questions").map(Question.init)
            //print(questions)
            self.results = try json.array("results").map(Result.init)
            updateResultValues()
            print(results)
            self.axis = try json.array("axis").map(Axis.init)
            //print(axis)
            self.graph = Graph(type: self.type, axis: axis, questions: self.questions, results: self.results)
            //print(graph)
        } catch {
            print("POSSIBLY FATAL ERROR: \(error)")
            title = "ERROR LOADING JSON"
            type = .Unknown
            questions = []
            results = []
            axis = []
            graph = nil
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
    
    func questionWithID(val: Int) -> Question? {
        for i in questions.indices {
            if questions[i].id == val {
                return questions[i]
            }
        }
        return nil
    }
    
    func updateResultValues() {
        switch type {
        case .Matrix:
            for i in results.indices {
                var resultValues: [Int] = []
                for j in results[i].questionIDs.indices {
                    if let question = questionWithID(results[i].questionIDs[j]) {
                        resultValues.append(question.answer)
                    }
                }
                results[i].rValues = resultValues
            }
        case .Triangle, .Pentagon, .Hexagon:
            for i in results.indices {
                var resultValues: [Int] = []
                for j in results[i].questionIDs.indices {
                    if let question = questionWithID(results[i].questionIDs[j]) {
                        resultValues.append(question.answer)
                    }
                }
                var average = 0
                for k in resultValues.indices {
                    average += resultValues[k]
                }
                average = Int( round( Float( average / resultValues.count) ) )
                results[i].rValues = [average]
            }
        case .Unknown: break
        }
    }
}
