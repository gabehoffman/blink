//
//  Axis+Freddy.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/17/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import Foundation
import Freddy

extension Axis: JSONDecodable {
    init(json value: JSON) throws {
        label = try value.string("label")
        id = try value.int("id")
    }
}

extension Axis: JSONEncodable {
    internal func toJSON() -> JSON {
        return .Dictionary( [ "label": .String(label), "id": .Int(id) ] )
    }
}
