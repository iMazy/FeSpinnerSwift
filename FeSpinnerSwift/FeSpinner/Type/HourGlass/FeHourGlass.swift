//
//  FeHourGlass.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/25.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeHourGlass: UIView {

    let kFe_HourGlass_Length: Float = 30.0
    let kFe_HourGlass_Duration: Double = 3.5
    
    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var isShowing: Bool = false
    
    var topLayer: CAShapeLayer!
    var bottomLayer: CAShapeLayer!
    var lineLayer: CAShapeLayer!
    var containerLayer: CALayer!
    var containerView: UIView!
    
    var topAnimation: CAKeyframeAnimation!
    var bottomAnimaiton: CAKeyframeAnimation!
    var lineAnimation: CAKeyframeAnimation!
    var containerAnimaton: CAKeyframeAnimation!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withView view: UIView) {
        self.init(frame: view.bounds)
        containerView = view
        
        initCommon()
        initContainer()
        initTop()
        initBottom()
        initLine()
        initAnimation()
    }
}

extension FeHourGlass {
    
    func initCommon() {
        backgroundColor = UIColor(hexStr: "DB7769")
        width = CGFloat(sqrtf(kFe_HourGlass_Length * kFe_HourGlass_Length + kFe_HourGlass_Length * kFe_HourGlass_Length))
        height = CGFloat(sqrtf(kFe_HourGlass_Length * kFe_HourGlass_Length - Float((width / 2.0) * (width / 2.0))))
    }
    
    func initContainer() {
        containerLayer = CALayer()
        containerLayer.backgroundColor = UIColor.clear.cgColor
        containerLayer.frame = CGRect(x: 0, y: 0, width: width, height: height * 2)
        containerLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        containerLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        self.layer.addSublayer(containerLayer)
    }
    
    func initTop() {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: width, y: height * 2))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: .zero)
        path.close()
        
        // top Layer
        topLayer = CAShapeLayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        topLayer.path = path.cgPath
        topLayer.fillColor = UIColor.white.cgColor
        topLayer.strokeColor = UIColor.white.cgColor
        topLayer.lineWidth = 0.0
        topLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        topLayer.position = CGPoint(x: width / 2, y: height)
        containerLayer.addSublayer(topLayer)
    }
    
    func initBottom() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.close()
        
        bottomLayer = CAShapeLayer()
        bottomLayer.frame = CGRect(x: 0, y: height, width: width, height: height)
        bottomLayer.path = path.cgPath
        bottomLayer.fillColor = UIColor.white.cgColor
        bottomLayer.strokeColor = UIColor.white.cgColor
        bottomLayer.lineWidth = 0.0
        bottomLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        bottomLayer.position = CGPoint(x: width / 2, y: height * 2)
        bottomLayer.transform = CATransform3DMakeScale(0, 0, 0)
        containerLayer.addSublayer(bottomLayer)
    }
    
    func initLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        
        // line layer
        lineLayer = CAShapeLayer()
        lineLayer.frame = CGRect(x: 0, y: height, width: width, height: height)
        lineLayer.strokeColor = UIColor.white.cgColor
        lineLayer.lineWidth = 1.0
        lineLayer.lineJoin = CAShapeLayerLineJoin.miter
        lineLayer.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 1)]
        lineLayer.lineDashPhase = 3.0
        lineLayer.path = path.cgPath
        lineLayer.strokeEnd = 0.0
        containerLayer.addSublayer(lineLayer)
        
    }
    
    func initAnimation() {
        // top animation
        topAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        topAnimation.duration = kFe_HourGlass_Duration
        topAnimation.repeatCount = MAXFLOAT
        topAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.9), NSNumber(value: 1.0)]
        topAnimation.values = [1.0, 0.0, 0.0]
        
        // bottom animation
        bottomAnimaiton = CAKeyframeAnimation(keyPath: "transform.scale")
        bottomAnimaiton.duration = kFe_HourGlass_Duration
        bottomAnimaiton.repeatCount = MAXFLOAT
        bottomAnimaiton.keyTimes = [NSNumber(value: 0.1), NSNumber(value: 0.9), NSNumber(value: 1.0)]
        bottomAnimaiton.values = [0.0, 1.0, 1.0]
        
        // line animaiton
        lineAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        lineAnimation.duration = kFe_HourGlass_Duration
        lineAnimation.repeatCount = MAXFLOAT
        lineAnimation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.1), NSNumber(value: 0.9), NSNumber(value: 1.0)]
        lineAnimation.values = [0.0, 1.0, 1.0, 1.0]
        
        // container animation
        containerAnimaton = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        containerAnimaton.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 1, 0.8, 0.0)
        containerAnimaton.duration = kFe_HourGlass_Duration
        containerAnimaton.repeatCount = MAXFLOAT
        containerAnimaton.keyTimes = [NSNumber(value: 0.8), NSNumber(value: 1.0)]
        containerAnimaton.values = [0.0, Double.pi]
    }
}

extension FeHourGlass {
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true
        
        topLayer.add(topAnimation, forKey: "TopAnimatin")
        bottomLayer.add(bottomAnimaiton, forKey: "BottomAnimation")
        lineLayer.add(lineAnimation, forKey: "LineAnimation")
        containerLayer.add(containerAnimaton, forKey: "ContainerAnimation")
    }
    
    func dismiss() {
        if !isShowing {
            return
        }
        isShowing = false
    }
    
    func showWhileExecutingClosure(_ closure: (()->Void)?) {
        self.showWhileExecutingClosure(closure, completion: nil)
    }
    
    func showWhileExecutingClosure(_ closure: (()->Void)?, completion: (()->Void)?) {
        if closure != nil {
            self.show()
            DispatchQueue.global(qos: .background).async {
                closure?()
                DispatchQueue.main.async {
                    completion?()
                    self.dismiss()
                }
            }
        }
    }
    
    func showWhileExecutingSelector(_ selector: Selector, onTarget target: NSObject?, withObject object: NSObject?, completion: (()->Void)?) {
        
        methodForExecuting = selector
        targetForExecuting = target
        objectForExecuting = object
        completionClosure = completion
        
        show()
        Thread.detachNewThreadSelector(#selector(executingMethod), toTarget: self, with: nil)
    }
    
    @objc func executingMethod() {
        targetForExecuting?.perform(methodForExecuting, with: objectForExecuting)
        
        DispatchQueue.main.async {
            self.completionClosure?()
            self.perform(#selector(self.cleanUp), on: .main, with: nil, waitUntilDone: false)
        }
    }
    
    @objc func cleanUp() {
        if objectForExecuting != nil {
            objectForExecuting = nil
        }
        if methodForExecuting != nil {
            methodForExecuting = nil
        }
        if targetForExecuting != nil {
            targetForExecuting = nil
        }
        dismiss()
    }
}
