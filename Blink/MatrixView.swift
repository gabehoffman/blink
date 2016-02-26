//
//  MatrixView.swift
//  Blink
//
//  Created by Gabe at Work on 2/26/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit
import Charts

@IBDesignable class MatrixView: UIView {
    
    var graph: Graph!
    
    @IBInspectable var maxXValue: Int = 10
    @IBInspectable var minXValue: Int = 0
    @IBInspectable var maxYValue: Int = 10
    @IBInspectable var minYValue: Int = 0
    @IBInspectable var xStrokeWeight: CGFloat = 5.0
    @IBInspectable var yStrokeWeight: CGFloat = 5.0
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let centerX = bounds.height/2 + 0.5
        let centerY = bounds.width/2 + 0.5
        print(center)
        
        //set up the width and height variables
        //for the horizontal stroke
        let matrixHeight: CGFloat = 400
        let matrixWidth: CGFloat = 400
        
        //create the path
        let matrixPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        matrixPath.lineWidth = xStrokeWeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        matrixPath.moveToPoint(CGPoint(
            x:bounds.width/2 - matrixWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        matrixPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + matrixWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        
        //set the path's line width to the height of the stroke
        matrixPath.lineWidth = yStrokeWeight
        
        //move the initial point of the path
        //to the start of the verticle stroke
        matrixPath.moveToPoint(CGPoint(
            x:centerY,
            y:centerX - matrixHeight/2 ))
        
        //add a point to the path at the end of the stroke
        matrixPath.addLineToPoint(CGPoint(
            x:centerY,
            y:centerX + matrixHeight/2))
        
        //set the stroke color
        UIColor.blackColor().setStroke()
        
        //draw the stroke
        matrixPath.stroke()
    }
    
}