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
        } catch {
            answer = 0
        }
        do {
            weight = try value.int("weight")
        } catch {
            weight = 1
        }
    }
}

extension Question: JSONEncodable {
    internal func toJSON() -> JSON {
        return .Dictionary( [   "question":     .String(text),
                                "answer":       .Int(answer),
                                "id":           .Int(id),
                                "weight":       .Int(weight)
                            ])
    }
}
