//
//  Result+Freddy.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/16/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//
//  Uses https://github.com/bignerdranch/Freddy

import Foundation
import Freddy

extension Result: JSONDecodable {
    init(json value: JSON) throws {
        text = try value.string("label")
        id = try value.int("id")
        questionIDs = try value.arrayOf("questions")
        
        do {
            rValues = try value.arrayOf("value")
            if rValues[0] < 0 {
                rValues = [Int( arc4random_uniform(10) + 1 )]
            }
        } catch {
            rValues = []
        }
        
    }
}

// NEEDS WORK- NOT FINISHED- QUESTIONS ARRAY NOT OUTPUTTING CORRECT ARRAY TYPE [Int] currently String
extension Result: JSONEncodable {
    internal func toJSON() -> JSON {
        var questionsArray: String = ""
        for i in questionIDs.indices {
            questionsArray += "\(questionIDs[i]),"
        }
        var resultsArray: String = ""
        for i in rValues.indices {
            resultsArray += "\(rValues[i]),"
        }
        return .Dictionary( [   "label":        .String(text),
                                "id":           .Int(id),
                                "questions":    .String(questionsArray),
                                "value" :       .String(resultsArray)
            ])
    }
}
