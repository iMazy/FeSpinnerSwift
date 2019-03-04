//
//  FeHandwritingView.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/3/4.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeHandwritingView: UIView {

    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    var isShowing: Bool = false
    
    private var containerView: UIView!
    private var loadingShapeLayer: CAShapeLayer!
    private var dotShapeLayer: CAShapeLayer!
    private var loadingKeyframeAnimation: CAKeyframeAnimation!
    private var dotKeyframeAnimation: CAKeyframeAnimation!
    
    convenience init(withView view: UIView) {
        let tempFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
        self.init(frame: tempFrame)
        
        self.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        
        containerView = view
        initCommon()
        initLoadingShapeLayer()
        initAnimation()
    }

}

extension FeHandwritingView {
    
    func initCommon() {
        backgroundColor = .clear
    }
    
    func initLoadingShapeLayer() {
        let loadingBezierPath = loadingShapeBezierPath()
        loadingShapeLayer = CAShapeLayer()
        loadingShapeLayer.frame = self.bounds
        loadingShapeLayer.path = loadingBezierPath.cgPath
        loadingShapeLayer.strokeEnd = 0
        loadingShapeLayer.strokeColor = UIColor.black.cgColor
        loadingShapeLayer.fillColor = UIColor.clear.cgColor
        loadingShapeLayer.lineWidth = 2.5
        loadingShapeLayer.lineCap = CAShapeLayerLineCap.round
        loadingShapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        let dotBezierPath = dotShapeBezierPath()
        dotShapeLayer = CAShapeLayer()
        dotShapeLayer.frame = self.bounds
        dotShapeLayer.path = dotBezierPath.cgPath
        dotShapeLayer.strokeEnd = 0
        dotShapeLayer.strokeColor = UIColor.black.cgColor
        dotShapeLayer.fillColor = UIColor.clear.cgColor
        dotShapeLayer.lineWidth = 2.5
        dotShapeLayer.lineCap = CAShapeLayerLineCap.round
        dotShapeLayer.lineJoin = CAShapeLayerLineJoin.round
    }
    
    func initAnimation() {
        // Loading
        loadingKeyframeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        loadingKeyframeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        loadingKeyframeAnimation.keyTimes = [0.0, 0.6, 1.0]
        loadingKeyframeAnimation.values = [0.0, 1.0, 1.0]
        loadingKeyframeAnimation.duration = 4.0
        loadingKeyframeAnimation.repeatCount = MAXFLOAT
        
        // dot
        dotKeyframeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        dotKeyframeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        dotKeyframeAnimation.keyTimes = [0.0, 0.6, 0.65, 1.0]
        dotKeyframeAnimation.values = [0.0, 0.0, 1.0, 1.0]
        dotKeyframeAnimation.duration = 4.0
        dotKeyframeAnimation.repeatCount = MAXFLOAT
    }
}

private extension FeHandwritingView {
    
    func loadingShapeBezierPath() -> UIBezierPath {
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 12, y: 55.14))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 13), controlPoint1: CGPoint(x: 43.08, y: 14.19), controlPoint2: CGPoint(x: 30.3, y: 13.07))
        return bezier2Path
        
    }
    
    func dotShapeBezierPath() -> UIBezierPath {
        let color0 = UIColor(r: 0, g: 0, b: 0, a: 1)
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 124.76, y: 27.14))
        bezier4Path.addCurve(to: CGPoint(x: 118.51, y: 27.69), controlPoint1: CGPoint(x: 123.13, y: 25.41), controlPoint2: CGPoint(x: 119.79, y: 25.69))
        bezier4Path.addCurve(to: CGPoint(x: 118.51, y: 27.69), controlPoint1: CGPoint(x: 123.13, y: 25.41), controlPoint2: CGPoint(x: 119.79, y: 25.69))
        bezier4Path.addCurve(to: CGPoint(x: 118.51, y: 27.69), controlPoint1: CGPoint(x: 123.13, y: 25.41), controlPoint2: CGPoint(x: 119.79, y: 25.69))
        bezier4Path.addCurve(to: CGPoint(x: 118.51, y: 27.69), controlPoint1: CGPoint(x: 123.13, y: 25.41), controlPoint2: CGPoint(x: 119.79, y: 25.69))
        return bezier4Path
    }
}

extension FeHandwritingView {
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true
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
