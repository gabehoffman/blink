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
        questionGrouping = try value.arrayOf("questions")
    }
}

// NEEDS WORK- NOT FINISHED- QUESTIONS ARRAY NOT OUTPUTTING CORRECT ARRAY TYPE
extension Result: JSONEncodable {
    internal func toJSON() -> JSON {
        var questionsArray: String = ""
        for i in questionGrouping.indices {
            questionsArray += "\(questionGrouping[i]),"
        }
        return .Dictionary( [   "label":     .String(text),
            "id":           .Int(id),
            "questions":    .String(questionsArray)
            ])
    }
}
