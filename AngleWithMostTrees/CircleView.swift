//
//  CircleView.swift
//  AngleWithMostTrees
//
//  Created by Rita Asryan on 10/26/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class  CircleView: UIView {
    override func draw(_ rect: CGRect) {
        let radius: Double = 100
        let rectCenter = CGPoint(x: rect.width / 2, y: rect.height / 2)

        if let forest = UIGraphicsGetCurrentContext(){
            forest.setLineWidth(3.0)
            
            UIColor.black.set()
            
            let center = CGPoint(x: rectCenter.x, y: rectCenter.y)
            
            forest.addArc(center: center, radius: CGFloat(radius), startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
            
            forest.strokePath()
        }
        
        if let camera = UIGraphicsGetCurrentContext(){
            camera.setLineWidth(1.0)
            
            UIColor.black.set()
            
            let center = CGPoint(x: rectCenter.x, y: rectCenter.y)
            
            camera.addArc(center: center, radius: 2, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
            
            camera.strokePath()
        }
    }

}
