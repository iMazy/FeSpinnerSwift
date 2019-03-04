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
        
        // add
        self.layer.addSublayer(loadingShapeLayer)
        self.layer.addSublayer(dotShapeLayer)
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
        bezier2Path.addCurve(to: CGPoint(x: 24.38, y: 16.51), controlPoint1: CGPoint(x: 27.14, y: 12.94), controlPoint2: CGPoint(x: 25.83, y: 14.46))
        bezier2Path.addCurve(to: CGPoint(x: 18.65, y: 46.28), controlPoint1: CGPoint(x: 17.66, y: 26.3), controlPoint2: CGPoint(x: 17.53, y: 43.17))
        bezier2Path.addCurve(to: CGPoint(x: 26.35, y: 57.19), controlPoint1: CGPoint(x: 19.77, y: 49.39), controlPoint2: CGPoint(x: 21.68, y: 56.4))
        bezier2Path.addCurve(to: CGPoint(x: 35.77, y: 52.3), controlPoint1: CGPoint(x: 29.97, y: 57.79), controlPoint2: CGPoint(x: 33.46, y: 55.27))
        bezier2Path.addCurve(to: CGPoint(x: 28.72, y: 43.43), controlPoint1: CGPoint(x: 38.07, y: 49.39), controlPoint2: CGPoint(x: 39.72, y: 45.88))
        bezier2Path.addCurve(to: CGPoint(x: 52.62, y: 42.31), controlPoint1: CGPoint(x: 45.25, y: 40.99), controlPoint2: CGPoint(x: 49.79, y: 39.86))
        bezier2Path.addCurve(to: CGPoint(x: 42.81, y: 43.43), controlPoint1: CGPoint(x: 49.33, y: 42.04), controlPoint2: CGPoint(x: 45.84, y: 42.04))
        bezier2Path.addCurve(to: CGPoint(x: 38.01, y: 51.44), controlPoint1: CGPoint(x: 39.78, y: 44.82), controlPoint2: CGPoint(x: 37.41, y: 48.13))
        bezier2Path.addCurve(to: CGPoint(x: 47.36, y: 56.27), controlPoint1: CGPoint(x: 38.73, y: 55.34), controlPoint2: CGPoint(x: 43.6, y: 57.52))
        bezier2Path.addCurve(to: CGPoint(x: 54.47, y: 47.34), controlPoint1: CGPoint(x: 51.11, y: 55.01), controlPoint2: CGPoint(x: 53.61, y: 51.24))
        bezier2Path.addCurve(to: CGPoint(x: 53.35, y: 41.71), controlPoint1: CGPoint(x: 54.86, y: 45.35), controlPoint2: CGPoint(x: 54.8, y: 43.04))
        bezier2Path.addCurve(to: CGPoint(x: 48.94, y: 43.23), controlPoint1: CGPoint(x: 51.9, y: 40.39), controlPoint2: CGPoint(x: 48.8, y: 41.25))
        bezier2Path.addCurve(to: CGPoint(x: 51.83, y: 45.75), controlPoint1: CGPoint(x: 49.07, y: 44.62), controlPoint2: CGPoint(x: 50.52, y: 45.42))
        bezier2Path.addCurve(to: CGPoint(x: 62.7, y: 43.96), controlPoint1: CGPoint(x: 55.45, y: 46.54), controlPoint2: CGPoint(x: 59.21, y: 45.29))
        bezier2Path.addCurve(to: CGPoint(x: 78.5, y: 50.84), controlPoint1: CGPoint(x: 77.18, y: 43.3), controlPoint2: CGPoint(x: 80.14, y: 47.47))
        bezier2Path.addCurve(to: CGPoint(x: 68.95, y: 42.04), controlPoint1: CGPoint(x: 78.1, y: 46.08), controlPoint2: CGPoint(x: 73.69, y: 41.98))
        bezier2Path.addCurve(to: CGPoint(x: 60.39, y: 51.5), controlPoint1: CGPoint(x: 64.21, y: 42.18), controlPoint2: CGPoint(x: 59.93, y: 46.74))
        bezier2Path.addCurve(to: CGPoint(x: 70.66, y: 58.65), controlPoint1: CGPoint(x: 60.85, y: 56.27), controlPoint2: CGPoint(x: 66.05, y: 60.04))
        bezier2Path.addCurve(to: CGPoint(x: 77.25, y: 46.01), controlPoint1: CGPoint(x: 75.6, y: 57.19), controlPoint2: CGPoint(x: 77.9, y: 51.17))
        bezier2Path.addCurve(to: CGPoint(x: 77.77, y: 56.8), controlPoint1: CGPoint(x: 76.06, y: 48.13), controlPoint2: CGPoint(x: 76.26, y: 54.94))
        bezier2Path.addCurve(to: CGPoint(x: 84.29, y: 58.65), controlPoint1: CGPoint(x: 79.29, y: 58.65), controlPoint2: CGPoint(x: 82.05, y: 59.44))
        bezier2Path.addCurve(to: CGPoint(x: 90.55, y: 48.06), controlPoint1: CGPoint(x: 87.19, y: 57.66), controlPoint2: CGPoint(x: 88.83, y: 50.64))
        bezier2Path.addCurve(to: CGPoint(x: 97.85, y: 43.3), controlPoint1: CGPoint(x: 92.26, y: 45.48), controlPoint2: CGPoint(x: 94.83, y: 42.84))
        bezier2Path.addCurve(to: CGPoint(x: 103.84, y: 51.17), controlPoint1: CGPoint(x: 101.28, y: 43.83), controlPoint2: CGPoint(x: 102.86, y: 47.8))
        bezier2Path.addCurve(to: CGPoint(x: 96.08, y: 43.5), controlPoint1: CGPoint(x: 104.04, y: 47.07), controlPoint2: CGPoint(x: 100.16, y: 43.23))
        bezier2Path.addCurve(to: CGPoint(x: 89.36, y: 52.17), controlPoint1: CGPoint(x: 91.99, y: 43.76), controlPoint2: CGPoint(x: 88.64, y: 48.06))
        bezier2Path.addCurve(to: CGPoint(x: 98.71, y: 57.92), controlPoint1: CGPoint(x: 90.08, y: 56.2), controlPoint2: CGPoint(x: 94.76, y: 59.11))
        bezier2Path.addCurve(to: CGPoint(x: 106.15, y: 45.48), controlPoint1: CGPoint(x: 103.58, y: 56.47), controlPoint2: CGPoint(x: 105.49, y: 50.58))
        bezier2Path.addCurve(to: CGPoint(x: 104.31, y: 16.57), controlPoint1: CGPoint(x: 107.4, y: 35.83), controlPoint2: CGPoint(x: 106.74, y: 25.97))
        bezier2Path.addCurve(to: CGPoint(x: 103.71, y: 50.25), controlPoint1: CGPoint(x: 102.33, y: 27.69), controlPoint2: CGPoint(x: 102.13, y: 39.07))
        bezier2Path.addCurve(to: CGPoint(x: 108.85, y: 60.04), controlPoint1: CGPoint(x: 104.24, y: 54.02), controlPoint2: CGPoint(x: 105.43, y: 58.38))
        bezier2Path.addCurve(to: CGPoint(x: 119.38, y: 55.54), controlPoint1: CGPoint(x: 112.67, y: 61.89), controlPoint2: CGPoint(x: 117.34, y: 59.24))
        bezier2Path.addCurve(to: CGPoint(x: 121.23, y: 43.1), controlPoint1: CGPoint(x: 121.36, y: 51.83), controlPoint2: CGPoint(x: 121.36, y: 47.34))
        bezier2Path.addCurve(to: CGPoint(x: 120.3, y: 54.81), controlPoint1: CGPoint(x: 120.24, y: 46.94), controlPoint2: CGPoint(x: 119.19, y: 50.97))
        bezier2Path.addCurve(to: CGPoint(x: 129.13, y: 60.7), controlPoint1: CGPoint(x: 121.36, y: 58.65), controlPoint2: CGPoint(x: 125.37, y: 61.96))
        bezier2Path.addCurve(to: CGPoint(x: 134.2, y: 52.23), controlPoint1: CGPoint(x: 132.42, y: 59.64), controlPoint2: CGPoint(x: 134, y: 55.74))
        bezier2Path.addCurve(to: CGPoint(x: 134.26, y: 41.78), controlPoint1: CGPoint(x: 134.39, y: 48.73), controlPoint2: CGPoint(x: 133.6, y: 45.22))
        bezier2Path.addCurve(to: CGPoint(x: 135.91, y: 62.09), controlPoint1: CGPoint(x: 133.08, y: 48.53), controlPoint2: CGPoint(x: 133.67, y: 55.61))
        bezier2Path.addCurve(to: CGPoint(x: 136.96, y: 47.93), controlPoint1: CGPoint(x: 136.24, y: 57.39), controlPoint2: CGPoint(x: 136.63, y: 52.63))
        bezier2Path.addCurve(to: CGPoint(x: 138.54, y: 43.3), controlPoint1: CGPoint(x: 137.09, y: 46.28), controlPoint2: CGPoint(x: 137.29, y: 44.36))
        bezier2Path.addCurve(to: CGPoint(x: 145.65, y: 46.74), controlPoint1: CGPoint(x: 140.91, y: 41.25), controlPoint2: CGPoint(x: 144.8, y: 43.7))
        bezier2Path.addCurve(to: CGPoint(x: 145.65, y: 56.13), controlPoint1: CGPoint(x: 146.51, y: 49.78), controlPoint2: CGPoint(x: 145.59, y: 53.03))
        bezier2Path.addCurve(to: CGPoint(x: 149.41, y: 62.55), controlPoint1: CGPoint(x: 145.72, y: 58.78), controlPoint2: CGPoint(x: 146.84, y: 61.89))
        bezier2Path.addCurve(to: CGPoint(x: 155.46, y: 58.98), controlPoint1: CGPoint(x: 151.84, y: 63.21), controlPoint2: CGPoint(x: 154.34, y: 61.23))
        bezier2Path.addCurve(to: CGPoint(x: 157.83, y: 51.7), controlPoint1: CGPoint(x: 156.65, y: 56.73), controlPoint2: CGPoint(x: 156.91, y: 54.08))
        bezier2Path.addCurve(to: CGPoint(x: 164.68, y: 44.82), controlPoint1: CGPoint(x: 159.08, y: 48.59), controlPoint2: CGPoint(x: 161.52, y: 45.88))
        bezier2Path.addCurve(to: CGPoint(x: 173.77, y: 47.27), controlPoint1: CGPoint(x: 167.84, y: 43.76), controlPoint2: CGPoint(x: 171.66, y: 44.62))
        bezier2Path.addCurve(to: CGPoint(x: 173.04, y: 56.27), controlPoint1: CGPoint(x: 175.87, y: 49.92), controlPoint2: CGPoint(x: 175.67, y: 54.15))
        bezier2Path.addCurve(to: CGPoint(x: 173.11, y: 44.69), controlPoint1: CGPoint(x: 175.94, y: 53.22), controlPoint2: CGPoint(x: 175.94, y: 47.87))
        bezier2Path.addCurve(to: CGPoint(x: 161.59, y: 43.43), controlPoint1: CGPoint(x: 170.28, y: 41.51), controlPoint2: CGPoint(x: 165.07, y: 41.05))
        bezier2Path.addCurve(to: CGPoint(x: 158.43, y: 54.75), controlPoint1: CGPoint(x: 158.1, y: 45.81), controlPoint2: CGPoint(x: 156.78, y: 50.84))
        bezier2Path.addCurve(to: CGPoint(x: 171.4, y: 59.57), controlPoint1: CGPoint(x: 160.47, y: 59.51), controlPoint2: CGPoint(x: 166.79, y: 61.89))
        bezier2Path.addCurve(to: CGPoint(x: 175.48, y: 46.28), controlPoint1: CGPoint(x: 176, y: 57.26), controlPoint2: CGPoint(x: 178.05, y: 50.78))
        bezier2Path.addCurve(to: CGPoint(x: 177.65, y: 85.97), controlPoint1: CGPoint(x: 176.2, y: 59.51), controlPoint2: CGPoint(x: 176.93, y: 72.74))
        bezier2Path.addCurve(to: CGPoint(x: 175.48, y: 92.59), controlPoint1: CGPoint(x: 177.78, y: 88.42), controlPoint2: CGPoint(x: 177.65, y: 91.39))
        bezier2Path.addCurve(to: CGPoint(x: 168.43, y: 88.29), controlPoint1: CGPoint(x: 172.78, y: 94.11), controlPoint2: CGPoint(x: 169.62, y: 91.2))
        bezier2Path.addCurve(to: CGPoint(x: 173.24, y: 66.52), controlPoint1: CGPoint(x: 165.4, y: 81.01), controlPoint2: CGPoint(x: 167.38, y: 71.88))
        bezier2Path.addCurve(to: CGPoint(x: 183.64, y: 59.31), controlPoint1: CGPoint(x: 176.33, y: 63.68), controlPoint2: CGPoint(x: 180.35, y: 61.96))
        bezier2Path.addCurve(to: CGPoint(x: 188.84, y: 48.46), controlPoint1: CGPoint(x: 186.93, y: 56.66), controlPoint2: CGPoint(x: 189.7, y: 52.63))
        return bezier2Path
        
    }
    
    func dotShapeBezierPath() -> UIBezierPath {
//        let color0 = UIColor(r: 0, g: 0, b: 0, a: 1)
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 124.76, y: 27.14))
        bezier4Path.addCurve(to: CGPoint(x: 118.51, y: 27.69), controlPoint1: CGPoint(x: 123.13, y: 25.41), controlPoint2: CGPoint(x: 119.79, y: 25.69))
        bezier4Path.addCurve(to: CGPoint(x: 120.85, y: 33.33), controlPoint1: CGPoint(x: 117.23, y: 29.68), controlPoint2: CGPoint(x: 118.51, y: 32.71))
        bezier4Path.addCurve(to: CGPoint(x: 125.26, y: 31.68), controlPoint1: CGPoint(x: 122.49, y: 33.74), controlPoint2: CGPoint(x: 124.34, y: 33.06))
        bezier4Path.addCurve(to: CGPoint(x: 124.76, y: 27.14), controlPoint1: CGPoint(x: 126.18, y: 30.3), controlPoint2: CGPoint(x: 125.9, y: 28.37))
        return bezier4Path
    }
}

extension FeHandwritingView {
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true
        
        loadingShapeLayer.add(loadingKeyframeAnimation, forKey: "stoke")
        dotShapeLayer.add(dotKeyframeAnimation, forKey: "stoke")
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
