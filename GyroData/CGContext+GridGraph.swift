//
//  CGContext+Extension.swift
//  GyroData
//
//  Created by Judy on 2022/12/27.
//

import UIKit

extension CGContext {
    func drawGridGraph(in size: CGSize) {
        self.saveGState()
        
        let horizontalSpacing = size.height / 8.0
        let verticalSpacing = size.width / 8.0
        let baselineForY = size.height / 2.0
        
        translateBy(x: 0, y: baselineForY)
        
        for index in -3...3 {
            let position = horizontalSpacing * CGFloat(index)
            
            move(to: CGPoint(x: 0, y: position))
            addLine(to: CGPoint(x: size.width, y: position))
        }
        
        for index in 1...7 {
            let position = verticalSpacing * CGFloat(index)
            
            move(to: CGPoint(x: position, y: baselineForY))
            addLine(to: CGPoint(x: position, y: -1 * baselineForY))
        }

        setStrokeColor(UIColor.systemGray.cgColor)
        strokePath()
     
        self.restoreGState()
    }
}
