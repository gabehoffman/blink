//
//  Graph.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/16/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import Foundation

enum Shape: String{
    case Matrix
    case Triangle
    case Pentagon
    case Hexagon
    case Unknown
}

struct Point {
    let x: Int
    let y: Int
    let text: String
    let value: Int
}

class Graph {
    var type: Shape {
        switch axis.count {
        case 2:
            return .Matrix
        case 3:
            return .Triangle
        case 5:
            return .Pentagon
        case 6:
            return .Hexagon
        default:
            return .Unknown
        }
    }
    let axis: [Axis]
    var points: [Point] = []
    
    init(type: Shape, axis: [Axis], questions: [Question], results: [Result] ) {
        self.axis = axis
        if self.type != type {
            print("Error in type check of Shape")
        }
        self.points = makePointsFrom(questions,results: results)
    }

    private func makePointsFrom(questions: [Question], results: [Result]) ->  [Point] {
        var points: [Point] = []
        if type == .Matrix {
            for i in results.indices {
                points.append( Point(   x: results[i].rValues[0],
                                        y: results[i].rValues[1],
                                        text: results[i].text,
                                        value: 1))
                print("Making a point named [\(results[i].text)] at x:\(points[i].x), y:\(points[i].y)")
            }
        } else {
            for i in results.indices {
                points.append( Point( x: results[i].id, y: results[i].rValues[0], text: results[i].text, value: 1 ))
                print("Making point named [\(results[i].text)] at x:\(axis[i]), y:\(results[i].rValues[0])")
            }
        }
        return points
    }
    
    static func makeShape(shape: String) -> Shape {
        switch shape {
            case "Matrix":
                return .Matrix
            case "Triangle":
                return .Triangle
            case "Pentagon":
                return .Pentagon
            case "Hexagon":
                return .Hexagon
            default:
                return .Unknown
            }
    }
}