//
//  Question+Freddy.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/16/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//
//  Uses https://github.com/bignerdranch/Freddy

import Foundation
import Freddy

extension Question: JSONDecodable {
    init(json value: JSON) throws {
        text = try value.string("question")
        id = try value.int("id")
        do {
            answer = try value.int("default")
            if answer < 0 {
                answer = Int( arc4random_uniform(10) + 1 )
            }
        } catch {
            answer = 0
        }
        do {
            weight = try value.int("weight")
        } catch {
            weight = 1
        }
        defaultValue = answer
    }
}

extension Question: JSONEncodable {
    internal func toJSON() -> JSON {
        return .Dictionary( [   "question":     .String(text),
                                "answer":       .Int(answer),
                                "id":           .Int(id),
                                "default":      .Int(defaultValue),
                                "weight":       .Int(weight)
                            ])
    }
}
