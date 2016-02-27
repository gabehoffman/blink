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
    @IBInspectable var xHashWidth: CGFloat = 15.0
    @IBInspectable var yHashHeight: CGFloat = 15.0
    @IBInspectable var xHashStrokeWeight: CGFloat = 5.0
    @IBInspectable var yHashStrokeWeight: CGFloat = 5.0
    @IBInspectable var xGridStrokeWeight: CGFloat = 1.0
    @IBInspectable var yGridStrokeWeight: CGFloat = 1.0
    @IBInspectable var xGrid: Bool = true
    @IBInspectable var yGrid: Bool = true
    @IBInspectable var xColor: UIColor = UIColor.blueColor()
    @IBInspectable var yColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let centerX = bounds.height / 2 + 0.5
        let centerY = bounds.width / 2 + 0.5
        let matrixWidth: CGFloat = bounds.width
        let matrixHeight: CGFloat = bounds.height
        
        print(center)
        
        drawAxis(matrixHeight, width: matrixWidth, centerX: centerX, centerY: centerY)

        //plotPointAt("point", x:7, y:6)
    }
    
    func drawAxis(height: CGFloat, width: CGFloat, centerX: CGFloat, centerY: CGFloat) {
        // Draw X/Y Background Grid Lines
        drawYGridLines(height)
        drawXGridLines(width)
        
        // Draw X/Y Axis Lines
        drawYAxis(height, centerX: centerX, centerY: centerY)
        drawXAxis(width, centerX: centerX, centerY: centerY)
        
        // Draw X/Y Axis Hash Marks
        drawYAxisMarks(height, centerX: centerX, centerY: centerY)
        drawXAxisMarks(width, centerX: centerX, centerY: centerY)
        

    }
    
    func drawXAxis(width: CGFloat, centerX: CGFloat, centerY: CGFloat) {
        
        //create the path
        let xPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        xPath.lineWidth = xStrokeWeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        xPath.moveToPoint(CGPoint(x: 0, y: centerX))
        
        //add a point to the path at the end of the stroke
        xPath.addLineToPoint(CGPoint(x: width,y: centerX))
        
        //set the stroke color
        xColor.setStroke()
        
        //draw the stroke
        xPath.stroke()
        
    }
    
    func drawYAxis(height: CGFloat, centerX: CGFloat, centerY: CGFloat)    {
        
        //create the path
        let yPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        yPath.lineWidth = yStrokeWeight
        
        //move the initial point of the path
        //to the start of the verticle stroke
        yPath.moveToPoint(CGPoint(x: centerY, y: 0 ))
        
        //add a point to the path at the end of the stroke
        yPath.addLineToPoint(CGPoint(x:centerY, y: height ))
        
        //set the stroke color
        yColor.setStroke()
        
        //draw the stroke
        yPath.stroke()
        
    }
    
    func drawXAxisMarks(width: CGFloat, centerX: CGFloat, centerY: CGFloat) {
        
        //create the path
        let hashXPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashXPath.lineWidth = xHashStrokeWeight
        
        let hashStepDistance = width / CGFloat(maxXValue)
        var xPoint: CGFloat = 0.5
        
        for _ in minXValue...maxXValue {
            
            let outOfLowerBounds = (xPoint - (xHashStrokeWeight / 2 )) < 0
            let outOfHigherBounds = (xPoint + (xHashStrokeWeight / 2 )) > width
            
            if outOfLowerBounds {
                xPoint += (xHashStrokeWeight / 2)
            }
            
            if outOfHigherBounds {
                xPoint = width - (xHashStrokeWeight / 2)
            }
            
            //move the initial point of the path to the start of the horizontal stroke
            hashXPath.moveToPoint( CGPoint( x: xPoint , y:centerX - (xHashWidth / 2) ) )
            
            //add a point to the path at the end of the stroke
            hashXPath.addLineToPoint( CGPoint( x: xPoint , y:centerX + (xHashWidth / 2) ) )
            
            xPoint += hashStepDistance
            
            if outOfLowerBounds {
                xPoint -= (xHashStrokeWeight / 2)
            }
        }
        
        //set the stroke color
        xColor.setStroke()
        
        //draw the stroke
        hashXPath.stroke()
        
    }
    
    func drawYAxisMarks(height: CGFloat, centerX: CGFloat, centerY: CGFloat)    {
        
        //create the path
        let hashYPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashYPath.lineWidth = yHashStrokeWeight
        
        let hashStepDistance = height / CGFloat(maxXValue)
        var yPoint: CGFloat = 0.5
        
        for _ in minXValue...maxXValue {
            let outOfLowerBounds = (yPoint - (yHashStrokeWeight / 2 )) < 0
            let outOfHigherBounds = (yPoint + (yHashStrokeWeight / 2 )) > height
            
            if outOfLowerBounds {
                yPoint += (yHashStrokeWeight / 2)
            }
            
            if outOfHigherBounds {
                yPoint = height - (yHashStrokeWeight / 2)
            }
            
            //move the initial point of the path to the start of the horizontal stroke
            hashYPath.moveToPoint( CGPoint( x: centerY  - (yHashHeight / 2) , y: yPoint ) )
            
            //add a point to the path at the end of the stroke
            hashYPath.addLineToPoint( CGPoint( x: centerY + (yHashHeight / 2), y: yPoint ) )
            
            yPoint += hashStepDistance
            
            if outOfLowerBounds {
                yPoint -= (yHashStrokeWeight / 2)
            }
        }
        
        //set the stroke color
        yColor.setStroke()
        
        //draw the stroke
        hashYPath.stroke()
        
    }
    
    func drawXGridLines(width: CGFloat) {
        
        //create the path
        let hashXPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashXPath.lineWidth = xGridStrokeWeight
        
        let hashStepDistance = width / CGFloat(maxXValue)
        var xPoint: CGFloat = 0.5
        
        for _ in minXValue...maxXValue {
            
            let outOfLowerBounds = (xPoint - (xGridStrokeWeight / 2 )) < 0
            let outOfHigherBounds = (xPoint + (xGridStrokeWeight / 2 )) > width
            
            if outOfLowerBounds && xGridStrokeWeight > 1 {
                xPoint += (xGridStrokeWeight / 2)
            }
            
            if outOfHigherBounds {
                xPoint = width - (xGridStrokeWeight / 2)
            }
            
            //move the initial point of the path to the start of the horizontal stroke
            hashXPath.moveToPoint( CGPoint( x: xPoint , y: 0 ) )
            
            //add a point to the path at the end of the stroke
            hashXPath.addLineToPoint( CGPoint( x: xPoint , y: width ) )
            
            xPoint += hashStepDistance
            
            if outOfLowerBounds {
                xPoint -= (xGridStrokeWeight / 2)
            }
        }
        
        //set the stroke color
        xColor.setStroke()
        
        //draw the stroke
        hashXPath.stroke()
        
    }
    
    
    func drawYGridLines(height: CGFloat)    {
        
        //create the path
        let hashYPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashYPath.lineWidth = yGridStrokeWeight
        
        let hashStepDistance = height / CGFloat(maxXValue)
        var yPoint: CGFloat = 0.5
        
        for _ in minXValue...maxXValue {
            let outOfLowerBounds = (yPoint - (yGridStrokeWeight / 2 )) < 0
            let outOfHigherBounds = (yPoint + (yGridStrokeWeight / 2 )) > height
            
            if outOfLowerBounds && yGridStrokeWeight > 1{
                yPoint += (yGridStrokeWeight / 2)
            }
            
            if outOfHigherBounds {
                yPoint = height - (yGridStrokeWeight / 2)
            }
            
            //move the initial point of the path to the start of the horizontal stroke
            hashYPath.moveToPoint( CGPoint( x: 0, y: yPoint ) )
            
            //add a point to the path at the end of the stroke
            hashYPath.addLineToPoint( CGPoint( x: height, y: yPoint ) )
            
            yPoint += hashStepDistance
            
            if outOfLowerBounds {
                yPoint -= (yGridStrokeWeight / 2)
            }
        }
        
        //set the stroke color
        yColor.setStroke()
        
        //draw the stroke
        hashYPath.stroke()
        
    }
    
}