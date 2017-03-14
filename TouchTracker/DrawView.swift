//
//  DrawView.swift
//  TouchTracker
//
//  Created by Marx, Brian on 3/14/17.
//  Copyright © 2017 Marx, Brian. All rights reserved.
//

import UIKit

class DrawView: UIView {
    //var currentLine: Line?
    var currentLines = [NSValue: Line]()
    
    var finishedLines = [Line]()
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        //Draw finished lines in black
        UIColor.black.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
//        if let line = currentLine {
//            //if there is a line currently being drawn, do it in red
//            UIColor.red.setStroke()
//            stroke(line)
//        }

        //Draw current lines in red
        UIColor.red.setStroke()
        for(_, line) in currentLines {
            stroke(line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        //get location of the touch in view's coordinate system
//        let location = touch.location(in: self)
//        
//        currentLine = Line(begin: location, end: location)
        //flags the view to be redrawn at the end of run loop
        
        //Log statement to see the order of events 
        print(#function)
        
        for touch in touches {
            let location = touch.location(in: self)
            
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        
//        currentLine?.end = location
        
        //Log statement to see the order of events
        print(#function)
        
        //lets drawView find the right Line
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    //update the end of the line location
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if var line = currentLine {
//            let touch = touches.first!
//            let location = touch.location(in: self)
//            line.end = location
//            finishedLines.append(line)
//        }
//        
//        currentLine = nil

        //Log statement to see the order of events
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
}
