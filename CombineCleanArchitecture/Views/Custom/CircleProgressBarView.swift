//
//  CircleProgressBarView.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

class CircleProgressBarView: UIView {

    var progressColor: UIColor = .white
    var progressBgColor: UIColor = .black
    var value: Double = 0
    
    private var circle: UIView!
    private var progressCircle: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
        drawCircleBgView()
        drawProgressView()
    }
    
    private func drawCircleBgView() {
        var progressBgCircle = CAShapeLayer()
        
        let centerPoint = CGPoint (x: layer.bounds.width / 2, y: layer.bounds.width / 2)
        let circleRadius : CGFloat = layer.bounds.width / 2 * 0.83
        
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: circleRadius,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        circlePath.lineWidth = 2.5
        
        progressBgCircle = CAShapeLayer ()
        progressBgCircle.path = circlePath.cgPath
        progressBgCircle.strokeColor = colorOfProgressBackground(value).cgColor
        progressBgCircle.fillColor = UIColor.clear.cgColor
        progressBgCircle.lineWidth = 2.5
        progressBgCircle.strokeStart = 0
        progressBgCircle.strokeEnd = 1.0
        layer.addSublayer(progressBgCircle)
    }
    
    private func drawProgressView() {
        progressCircle = CAShapeLayer()
        let progress = CGFloat(value) / 100
        let centerPoint = CGPoint (x: layer.bounds.width / 2, y: layer.bounds.width / 2)
        let circleRadius : CGFloat = layer.bounds.width / 2 * 0.83
        
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: circleRadius,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = colorOfProgress(value).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 2.5
        progressCircle.strokeStart = 0
        progressCircle.strokeEnd = progress
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progress
        animation.duration = 0.5
        animation.fillMode = CAMediaTimingFillMode.forwards
        progressCircle.add(animation, forKey: "ani")
        
        layer.addSublayer(progressCircle)
    }
    
    /// Progress value
    /// min: 0
    /// max: 100
    func setValue(value: Double) {
        self.value  = value
        
        if value < 0 { self.value = 0 }
        else if value > 100 { self.value = 100 }

        setNeedsDisplay()
    }
    
    private func colorOfProgress(_ progress: Double) -> UIColor {
        return progress >= 50 ? AppConstants.Color.progressBarGood : AppConstants.Color.progressBarAverage
    }
    
    private func colorOfProgressBackground(_ progress: Double) -> UIColor {
        return progress >= 50 ? AppConstants.Color.progressBarGoodBackground : AppConstants.Color.progressBarAverageBackground
    }
}
