//
//  tangram.swift
//  Saint Seiya
//
//  Created by 江齐松 on 16/5/9.
//  Copyright © 2016年 江齐松. All rights reserved.
//

import UIKit

enum assembleType:Int{
    case fox = 0
}

class Tangram: UIView {

    var progress:CGFloat = 0 {
        didSet{
            if progress < 1 {
                self.disruptSevensWith(progress)
            }else {
                self.assembleSevensTo(.fox)
            }
        }
    }
    

    var width : CGFloat = 0
    var halfWidth : CGFloat = 0
    var quarterWidth : CGFloat = 0
    var quarterWidth_3 : CGFloat = 0

    lazy var orangeTriangle:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.width, y: 0))
        path.addLine(to: CGPoint(x: self.halfWidth, y: -self.halfWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let triangle = CAShapeLayer()
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.orange.cgColor
        triangle.anchorPoint = CGPoint(x: 0, y: 0)
        triangle.position = CGPoint(x: 0,y: 0)
        return triangle
    }()//大三角板1
    
    lazy var greenTriangle:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: self.width))
        path.addLine(to: CGPoint(x: self.halfWidth, y: self.halfWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let triangle = CAShapeLayer()
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.green.cgColor
        triangle.anchorPoint = CGPoint(x: 0, y: 0)
        triangle.position = CGPoint(x: 0,y: 0)
        return triangle
    }()//大三角板2

    lazy var brownTriangle:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.halfWidth, y: 0))
        path.addLine(to: CGPoint(x: self.quarterWidth, y: self.quarterWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let triangle = CAShapeLayer()
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.brown.cgColor
        triangle.anchorPoint = CGPoint(x: 0, y: 0)
        triangle.position = CGPoint(x: 0,y: 0)
        return triangle
    }()//小三角板1

    lazy var yellowSquare:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: -self.quarterWidth, y: self.quarterWidth))
        path.addLine(to: CGPoint(x: 0, y: self.halfWidth))
        path.addLine(to: CGPoint(x: self.quarterWidth, y: self.quarterWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let square = CAShapeLayer()
        square.path = path.cgPath
        square.fillColor = UIColor.yellow.cgColor
        square.anchorPoint = CGPoint(x: 0, y: 0)
        square.position = CGPoint(x: 0,y: 0)
        return square
    }()//正方形板1

    lazy var blueParallelogram:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: self.halfWidth))
        path.addLine(to: CGPoint(x: self.quarterWidth,y: self.quarterWidth + self.halfWidth))
        path.addLine(to: CGPoint(x: self.quarterWidth, y: self.quarterWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let parallelogram = CAShapeLayer()
        parallelogram.path = path.cgPath
        parallelogram.fillColor = UIColor.blue.cgColor
        parallelogram.anchorPoint = CGPoint(x: 0, y: 0)
        parallelogram.position = CGPoint(x: 0,y: 0)
        return parallelogram
    }()//平行四边形板1
    
    lazy var indigoTriangle:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.quarterWidth, y: -self.quarterWidth))
        path.addLine(to: CGPoint(x: self.quarterWidth, y: self.quarterWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let triangle = CAShapeLayer()
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.purple.cgColor
        triangle.anchorPoint = CGPoint(x: 0, y: 0)
        triangle.position = CGPoint(x: 0,y: 0)
        return triangle
    }()//小三角板2

    lazy var redTriangle:CAShapeLayer = {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.halfWidth, y: 0))
        path.addLine(to: CGPoint(x: self.halfWidth, y: self.halfWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let triangle = CAShapeLayer()
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.red.cgColor
        triangle.anchorPoint = CGPoint(x: 0, y: 0)
        triangle.position = CGPoint(x: 0,y: 0)
        return triangle
    }()//中三角板1
    
    let anim = CABasicAnimation.init(keyPath: "transform")
    var current:Float?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.width = frame.size.width
        self.halfWidth = self.width * 0.5
        self.quarterWidth = self.width * 0.25
        self.quarterWidth_3 = self.width * 0.75
        
        orangeTriangle.frame.origin = CGPoint(x: 0, y: self.width)
        greenTriangle.frame.origin = CGPoint(x: 0, y: 0)
        brownTriangle.frame.origin = CGPoint(x: 0, y: 0)
        yellowSquare.frame.origin = CGPoint(x: self.halfWidth, y: 0)
        blueParallelogram.frame.origin = CGPoint(x: self.quarterWidth + self.halfWidth, y: self.quarterWidth)
        indigoTriangle.frame.origin = CGPoint(x: self.halfWidth, y: self.halfWidth)
        redTriangle.frame.origin = CGPoint(x: self.halfWidth, y: 0)
        
//        self.layer.addSublayer(orangeTriangle)
//        self.layer.addSublayer(greenTriangle)
//        self.layer.addSublayer(brownTriangle)
//        self.layer.addSublayer(yellowSquare)
//        self.layer.addSublayer(blueParallelogram)
//        self.layer.addSublayer(indigoTriangle)
        self.layer.addSublayer(redTriangle)
        
        print(orangeTriangle.frame)
        print(greenTriangle.frame)
        print(brownTriangle.frame)
        print(yellowSquare.frame)
        print(blueParallelogram.frame)
        print(indigoTriangle.frame)
        print(redTriangle.frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func updateTangramBy(_ progress:CGFloat){
        
    }

    func animateTri() {
        current = (orangeTriangle.value(forKeyPath: "transform.rotation.z") as AnyObject).floatValue
        
        let rot = Double.pi/4
        
        anim.duration = 5
        let clunk = CAMediaTimingFunction.init(controlPoints: 0.9, 0.1, 0.7, 0.9)
        anim.timingFunction = clunk
        anim.fromValue = current
        anim.toValue = Double(current!) + rot
        anim.valueFunction = CAValueFunction.init(name: "rotateZ")
        orangeTriangle.add(anim, forKey: nil)

    }

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        animateTri()
//        brownTriangle.frame.origin.x = self.halfWidth
//        print(brownTriangle.frame)
//    }
    
    
    func disruptSevensWith(_ progress:CGFloat) {
        orangeTriangle.frame.origin = CGPoint(x: 0 + progress*0, y: 200 + progress*80)
        greenTriangle.frame.origin = CGPoint(x: 0 - progress*self.halfWidth, y: 0 + progress*self.quarterWidth)
        brownTriangle.frame.origin = CGPoint(x: 0 - progress*(self.quarterWidth+self.halfWidth), y: 0 - progress*(self.quarterWidth))
//        yellowSquare.frame.origin = CGPoint(x: self.halfWidth + progress*0, y: 0 - progress*1self.quarterWidth)
        
//        blueParallelogram.frame.origin = CGPoint(x: 1self.quarterWidth + progress*1self.quarterWidth, y: self.quarterWidth + progress*0)
//        indigoTriangle.frame.origin = CGPoint(x: self.halfWidth + progress*0, y: self.halfWidth + progress*0)
//        redTriangle.frame.origin = CGPoint(x: self.halfWidth + progress*1self.quarterWidth, y: 0 - progress*1self.quarterWidth)
    }
    
    func assembleSevensTo(_ type:assembleType) {
//        self.assembleSevensToFox()
        
        
        redTriangle.frame.origin = CGPoint(x: self.quarterWidth, y: self.halfWidth * sqrt(2))
        redTriangle.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4 * 5), 0, 0, 1)
        
    }
    
    func assembleSevensToFox() {
        orangeTriangle.frame.origin = CGPoint(x: self.quarterWidth_3, y: self.halfWidth)
        orangeTriangle.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4 * 3), 0, 0, 1)
        
        greenTriangle.frame.origin = CGPoint(x: self.quarterWidth, y: 0)
        
        brownTriangle.frame.origin = CGPoint(x: 0, y: -self.quarterWidth)
        brownTriangle.transform = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0, 0, -1)

        //基准
        yellowSquare.frame.origin = CGPoint(x: self.quarterWidth, y: -self.halfWidth)

        blueParallelogram.frame.origin = CGPoint(x: 300, y: self.quarterWidth + self.halfWidth * sqrt(2))
        blueParallelogram.transform = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0, 0, 1)
        
        
        indigoTriangle.frame.origin = CGPoint(x: self.quarterWidth, y: -self.halfWidth)
        
        redTriangle.frame.origin = CGPoint(x: self.quarterWidth, y: self.halfWidth * sqrt(2))
        redTriangle.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4 * 5), 0, 0, 1)
    }
    
    
    
    func startAnimation() {
        
    }
    
    func endAnimation() {
        
    }
    
}
