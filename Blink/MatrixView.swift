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
    var rect: CGRect!
    var labels: [UILabel] = []
    var points: [CGRect] = []
    var labelsCollisionCount: [Int] = []
    let π:CGFloat = CGFloat(M_PI)
    
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
    @IBInspectable var xColor: UIColor = UIColor.orangeColor()
    @IBInspectable var yColor: UIColor = UIColor.orangeColor()
    @IBInspectable var xHashColor: UIColor = UIColor.blackColor()
    @IBInspectable var yHashColor: UIColor = UIColor.blackColor()
    @IBInspectable var xGridColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var yGridColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var pointColor: UIColor = UIColor.blueColor()
    @IBInspectable var pointFontSize: CGFloat = 12
    
    
    var unitXDistance: CGFloat = 20
    var unitYDistance: CGFloat = 20
    
    override func drawRect(rect: CGRect) {
        self.rect = rect
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let centerX = bounds.height / 2 + 0.5
        let centerY = bounds.width / 2 + 0.5
        let matrixWidth: CGFloat = bounds.width
        let matrixHeight: CGFloat = bounds.height
        unitXDistance = bounds.width / CGFloat(maxXValue)
        unitYDistance = bounds.width / CGFloat(maxXValue)
        
        print(center)
        
        drawAxis(matrixHeight, width: matrixWidth, centerX: centerX, centerY: centerY)

        if graph == nil {
            // Plot points for Interface Builder
            plotPointAt("Point 1", x:7, y:6)
            plotPointAt("Point 2", x:2, y:6)
            plotPointAt("Point 3", x:8, y:8)
            plotPointAt("Point 4", x:3, y:1)
            plotPointAt("Point 5", x:4, y:4)
            plotPointAt("Point 6", x:7, y:6)
            plotPointAt("Point 7", x:7, y:6)
            plotPointAt("Point 8", x:7, y:6)
            plotPointAt("Point 9", x:7, y:7)
            plotPointAt("Point 10", x:7, y:8)
            plotPointAt("Point 11", x:7, y:8)
            plotPointAt("Point 12", x:10, y:6)
        } else {
            for point in graph.points {
                print(point)
                plotPointAt(point.text, x: point.x, y: point.y)
            }
        }
    }
    
    func drawAxis(height: CGFloat, width: CGFloat, centerX: CGFloat, centerY: CGFloat) {
        // Draw X/Y Background Grid Lines
        //drawYGridLines(height)
        //drawXGridLines(width)
        
        // Draw X/Y Axis Lines
        drawYAxis(height, centerX: centerX, centerY: centerY)
        drawXAxis(width, centerX: centerX, centerY: centerY)
        
        // Draw X/Y Axis Hash Marks
        drawYHashMarks(height, centerX: centerX, centerY: centerY)
        drawXHashMarks(width, centerX: centerX, centerY: centerY)
        

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
    
    func drawXHashMarks(width: CGFloat, centerX: CGFloat, centerY: CGFloat) {
        
        //create the path
        let hashXPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashXPath.lineWidth = xHashStrokeWeight
        
        let hashStepDistance = unitXDistance
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
        xHashColor.setStroke()
        
        //draw the stroke
        hashXPath.stroke()
        
    }
    
    func drawYHashMarks(height: CGFloat, centerX: CGFloat, centerY: CGFloat)    {
        
        //create the path
        let hashYPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashYPath.lineWidth = yHashStrokeWeight
        
        let hashStepDistance = unitYDistance
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
        yHashColor.setStroke()
        
        //draw the stroke
        hashYPath.stroke()
        
    }
    
    func drawXGridLines(width: CGFloat) {
        
        //create the path
        let hashXPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashXPath.lineWidth = xGridStrokeWeight
        
        let hashStepDistance = unitXDistance
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
        xGridColor.setStroke()
        
        //draw the stroke
        hashXPath.stroke()
        
    }
    
    
    func drawYGridLines(height: CGFloat)    {
        
        //create the path
        let hashYPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        hashYPath.lineWidth = yGridStrokeWeight
        
        let hashStepDistance = unitYDistance
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
        yGridColor.setStroke()
        
        //draw the stroke
        hashYPath.stroke()
        
    }
    
    func plotPointAt(label: String, x: Int, y: Int) {
        
        let pointX: CGFloat = CGFloat(x) * unitXDistance + 0.5
        let pointY: CGFloat = bounds.height - CGFloat(y) * unitYDistance + 0.5
        
        let center = CGPoint(x: pointX, y: pointY)
        let radius: CGFloat = max(8,8 )
        let arcWidth: CGFloat = 4
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π
        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path.lineWidth = arcWidth
        pointColor.setStroke()
        path.stroke()
        points.append(path.bounds)
        
        
        let labelWidth: CGFloat = CGFloat(label.characters.count) * pointFontSize * 0.5
        var labelX = pointX - (labelWidth / 2)
        var labelY = pointY + 4
        if labelX + labelWidth > bounds.width {
            labelX -= labelWidth / 2
        }
        if labelY + pointFontSize > bounds.height{
            labelY -= pointFontSize * 2
        }
        let pointLabel = UILabel(frame: CGRectMake(labelX, labelY, labelWidth, pointFontSize))
        pointLabel.text = label
        pointLabel.textAlignment = NSTextAlignment.Center
        pointLabel.textColor = pointColor
        //pointLabel.backgroundColor = UIColor.lightGrayColor()
        pointLabel.font = pointLabel.font.fontWithSize(pointFontSize)
        fixLabelCollisions(pointLabel)
        labels.append(pointLabel)
        labelsCollisionCount.append(0)
        self.addSubview(pointLabel)
    }
    
    func fixLabelCollisions(label: UILabel) {
        let adjustment: CGFloat = 8
        for i in labels.indices {
            if CGRectIntersectsRect(labels[i].frame, label.frame) {
                labelsCollisionCount[i]++
                if (labelsCollisionCount[i] == 8) {
                    //label.frame.offsetInPlace(dx: 0, dy: -10)
                }
                if (labelsCollisionCount[i] == 3) {
                    label.frame.offsetInPlace(dx: label.frame.width / 2 + adjustment, dy: -pointFontSize)
                }
                if (labelsCollisionCount[i] == 2) {
                    label.frame.offsetInPlace(dx: -label.frame.width / 2  - adjustment, dy: -pointFontSize)
                }
                if (labelsCollisionCount[i] == 1) {
                    label.frame.offsetInPlace(dx: 0, dy: -pointFontSize * 2)
                }
            }
        }
    }
    
    func isOutOfBounds(label: UILabel) -> Bool {
        var isOut = false
        if label.frame.maxX > bounds.width ||
            label.frame.minX < 0 {
            isOut = true
        }
        print("\(label.text) maxX = \(label.frame.maxX)")
        return isOut
    }

}