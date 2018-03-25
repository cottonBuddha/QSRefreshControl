//
//  tangram.swift
//  Saint Seiya
//
//  Created by 江齐松 on 16/5/9.
//  Copyright © 2016年 江齐松. All rights reserved.
//

import UIKit
enum assembleType: Int{
  case fox = 0
}

class Tangram: UIView, QSRefreshMotionProtocol {
  
  var sideLength: CGFloat = 50
  
  lazy var orangeTriangle:CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.5, y: -self.sideLength * 0.5))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let triangle = CAShapeLayer()
    triangle.path = path.cgPath
    triangle.fillColor = UIColor.orange.cgColor
    triangle.anchorPoint = CGPoint(x: 0, y: 0)
    triangle.position = CGPoint(x: 0,y: 0)
    return triangle
  }()//大三角板1
  
  lazy var greenTriangle: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 0, y: self.sideLength))
    path.addLine(to: CGPoint(x: self.sideLength * 0.5, y: self.sideLength * 0.5))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let triangle = CAShapeLayer()
    triangle.path = path.cgPath
    triangle.fillColor = UIColor.green.cgColor
    triangle.anchorPoint = CGPoint(x: 0, y: 0)
    triangle.position = CGPoint(x: 0,y: 0)
    return triangle
  }()//大三角板2
  
  lazy var brownTriangle: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.5, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25, y: self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let triangle = CAShapeLayer()
    triangle.path = path.cgPath
    triangle.fillColor = UIColor.brown.cgColor
    triangle.anchorPoint = CGPoint(x: 0, y: 0)
    triangle.position = CGPoint(x: 0,y: 0)
    return triangle
  }()//小三角板1
  
  lazy var yellowSquare: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: -self.sideLength * 0.25, y: self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: 0, y: self.sideLength * 0.5))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25, y: self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let square = CAShapeLayer()
    square.path = path.cgPath
    square.fillColor = UIColor.yellow.cgColor
    square.anchorPoint = CGPoint(x: 0, y: 0)
    square.position = CGPoint(x: 0,y: 0)
    return square
  }()//正方形板1
  
  lazy var blueParallelogram: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 0, y: self.sideLength * 0.5))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25,y: self.sideLength * 0.75))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25, y: self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let parallelogram = CAShapeLayer()
    parallelogram.path = path.cgPath
    parallelogram.fillColor = UIColor.blue.cgColor
    parallelogram.anchorPoint = CGPoint(x: 0, y: 0)
    parallelogram.position = CGPoint(x: 0,y: 0)
    return parallelogram
  }()//平行四边形板1
  
  lazy var indigoTriangle: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25, y: -self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: self.sideLength * 0.25, y: self.sideLength * 0.25))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    let triangle = CAShapeLayer()
    triangle.path = path.cgPath
    triangle.fillColor = UIColor.purple.cgColor
    triangle.anchorPoint = CGPoint(x: 0, y: 0)
    triangle.position = CGPoint(x: 0,y: 0)
    return triangle
  }()//小三角板2
  
  lazy var redTriangle: CAShapeLayer = {
    let path = UIBezierPath.init()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.5, y: 0))
    path.addLine(to: CGPoint(x: self.sideLength * 0.5, y: self.sideLength * 0.5))
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
    orangeTriangle.position = CGPoint(x: 0, y: self.sideLength)
    greenTriangle.position = CGPoint(x: 0, y: -10)
    blueParallelogram.position = CGPoint(x: self.sideLength * 0.75, y: self.sideLength * 0.25 - 20)
    indigoTriangle.position = CGPoint(x: self.sideLength * 0.5, y: self.sideLength * 0.5 - 30)
    yellowSquare.position = CGPoint(x: self.sideLength * 0.5, y: -40)
    brownTriangle.position = CGPoint(x: 0, y: -50)
    redTriangle.position = CGPoint(x: self.sideLength * 0.5, y: -60)

//    orangeTriangle.opacity = 0
//    greenTriangle.opacity = 0
//    indigoTriangle.opacity = 0
//    blueParallelogram.opacity = 0
//    yellowSquare.opacity = 0
//    brownTriangle.opacity = 0
//    redTriangle.opacity = 0
    
    self.layer.addSublayer(orangeTriangle)
    self.layer.addSublayer(greenTriangle)
    self.layer.addSublayer(brownTriangle)
    self.layer.addSublayer(yellowSquare)
    self.layer.addSublayer(blueParallelogram)
    self.layer.addSublayer(indigoTriangle)
    self.layer.addSublayer(redTriangle)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func updateTangramBy(_ progress:CGFloat) {
    let orangeProgress = CGFloat(min(0.14, max(0, progress))) / 0.14
    let greenProgress = CGFloat(min(0.28, max(0.14, progress)) - 0.14) / 0.14
    let indigoProgress = CGFloat(min(0.42, max(0.28, progress)) - 0.28) / 0.14
    let blueProgress = CGFloat(min(0.56, max(0.42, progress)) - 0.42) / 0.14
    let yellowProgress = CGFloat(min(0.70, max(0.56, progress)) - 0.56) / 0.14
    let brownProgress = CGFloat(min(0.84, max(0.70, progress)) - 0.70) / 0.14
    let redProgress = CGFloat(min(1, max(0.84, progress)) - 0.84) / 0.16
    
    orangeTriangle.opacity = Float(orangeProgress)
    greenTriangle.opacity = Float(greenProgress)
    indigoTriangle.opacity = Float(indigoProgress)
    blueParallelogram.opacity = Float(blueProgress)
    yellowSquare.opacity = Float(yellowProgress)
    brownTriangle.opacity = Float(brownProgress)
    redTriangle.opacity = Float(redProgress)
    
    self.greenTriangle.position.y = -10 + greenProgress * 10;
    self.blueParallelogram.position.y = self.sideLength * 0.25 - 20 + blueProgress * 20;
    self.indigoTriangle.position.y = self.sideLength * 0.5 - 30 + indigoProgress * 30;
    self.yellowSquare.position.y = -40 + yellowProgress * 40;
    self.brownTriangle.position.y = -50 + brownProgress * 50;
    self.redTriangle.position.y = -60 + redProgress * 60;
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
  
  func disruptSevensWith(_ progress: CGFloat) {
    orangeTriangle.frame.origin = CGPoint(x: 0 + progress*0, y: self.sideLength + progress*80)
    greenTriangle.frame.origin = CGPoint(x: 0 - progress*self.sideLength * 0.5, y: 0 + progress*self.sideLength * 0.25)
    brownTriangle.frame.origin = CGPoint(x: 0 - progress*self.sideLength * 0.75, y: 0 - progress*self.sideLength * 0.75)
    yellowSquare.frame.origin = CGPoint(x: self.sideLength * 0.5 + progress*0, y: 0 - progress*self.sideLength * 0.75)
    blueParallelogram.frame.origin = CGPoint(x: self.sideLength * 0.75 + progress*self.sideLength * 0.75, y: self.sideLength * 0.25 + progress*0)
    indigoTriangle.frame.origin = CGPoint(x: self.sideLength * 0.5 + progress*0, y: self.sideLength * 0.5 + progress*0)
    redTriangle.frame.origin = CGPoint(x: self.sideLength * 0.5 + progress*self.sideLength * 0.75, y: 0 - progress*self.sideLength * 0.75)
  }
  
  func assembleSevensTo(_ type: assembleType) {
    self.assembleSevensToFox()
  }
  
  func assembleSevensToFox() {
    orangeTriangle.frame.origin = CGPoint(x: self.sideLength * 0.75, y: self.sideLength * 0.5)
    orangeTriangle.transform = CATransform3DMakeRotation(.pi/4 * 3, 0, 0, 1)
    
    greenTriangle.frame.origin = CGPoint(x: self.sideLength * 0.25, y: 0)
    
    brownTriangle.frame.origin = CGPoint(x: 0, y: -self.sideLength * 0.25)
    brownTriangle.transform = CATransform3DMakeRotation(.pi/2, 0, 0, -1)
    
    //基准
    yellowSquare.frame.origin = CGPoint(x: self.sideLength * 0.25, y: -self.sideLength * 0.5)
    
    blueParallelogram.frame.origin = CGPoint(x: self.sideLength * 1.5, y: self.sideLength * 0.25 + self.sideLength * 0.5 * sqrt(2))
    blueParallelogram.transform = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
    
    indigoTriangle.frame.origin = CGPoint(x: self.sideLength * 0.25, y: -self.sideLength * 0.5)
    
    redTriangle.frame.origin = CGPoint(x: self.sideLength * 0.25, y: self.sideLength * 0.5 * sqrt(2))
    redTriangle.transform = CATransform3DMakeRotation(.pi/4 * 5, 0, 0, 1)
  }
  
  func assembleSevensToOrigin() {
    orangeTriangle.frame.origin = CGPoint(x: 0, y: self.sideLength)
    orangeTriangle.transform = CATransform3DMakeRotation(0, 0, 0, 1)

    greenTriangle.frame.origin = CGPoint(x: 0, y: -10)
    indigoTriangle.frame.origin = CGPoint(x: self.sideLength * 0.5, y: self.sideLength * 0.5 - 30)
    blueParallelogram.frame.origin = CGPoint(x: self.sideLength * 0.75, y: self.sideLength * 0.25 - 20)
    blueParallelogram.transform = CATransform3DMakeRotation(0, 0, 0, 1)

    yellowSquare.frame.origin = CGPoint(x: self.sideLength * 0.5, y: -40)
    brownTriangle.frame.origin = CGPoint(x: 0, y: -50)
    brownTriangle.transform = CATransform3DMakeRotation(0, 0, 0, -1)

    redTriangle.frame.origin = CGPoint(x: self.sideLength * 0.5, y: -60)
    redTriangle.transform = CATransform3DMakeRotation(0, 0, 0, 1)

    orangeTriangle.opacity = 0
    greenTriangle.opacity = 0
    indigoTriangle.opacity = 0
    blueParallelogram.opacity = 0
    yellowSquare.opacity = 0
    brownTriangle.opacity = 0
    redTriangle.opacity = 0
  }
  
  func startShining() {
    let alpha = CABasicAnimation.init(keyPath: "opacity")
    alpha.fromValue = 1
    alpha.toValue = 0.3
    alpha.repeatCount = 10000
    alpha.autoreverses = true
    alpha.duration = 0.5
    
    [orangeTriangle, greenTriangle, redTriangle, yellowSquare, blueParallelogram, brownTriangle, indigoTriangle].forEach {
      $0.add(alpha, forKey: "alpha")
    }
  }
  
  func stopShining() {
    [orangeTriangle, greenTriangle, redTriangle, yellowSquare, blueParallelogram, brownTriangle, indigoTriangle].forEach {
      $0.removeAllAnimations()
    }
  }
  
  //MARK:实现QSRefreshMotionProtocol
  func draggingBeforeRelease(withOffset offset: CGFloat) {
    updateTangramBy(max(offset - 30, 0) / 90)
  }
  
  func releaseAndBeginRefreshing() {
    assembleSevensTo(.fox)
    startShining()
  }
  
  func stopRefreshingAndBackToOrigin() {
    stopShining()
  }
  
  func endAll() {
    assembleSevensToOrigin()
  }
  
  func triggerDistance() -> CGFloat {
    return 120
  }
}
