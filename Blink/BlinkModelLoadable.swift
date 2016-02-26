//
//  BlinkModelLoadable.swift
//  Blink
//
//  Created by Gabe at Work on 2/26/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import Foundation

protocol BlinkModelLoadable: DataURLLoadable {
    
    var blink: BlinkModel!  { get set }
    
    func loadBlinkModel()    
}