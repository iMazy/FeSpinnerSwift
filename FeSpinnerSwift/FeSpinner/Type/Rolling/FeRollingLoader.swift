//
//  FeRollingLoader.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/28.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeRollingLoader: UIView {

    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    private let kFe_Color_DarkShalmon: String = "E9967A"
    private let kFe_Circle_Width: CGFloat = 100.0
    private let kFe_Color_Salmon: String = "FA8072"
    
    var isShowing: Bool = false
    var title: String = ""
    
    // container
    var containerView: UIView!
    // circle
    var circleLayer: CAShapeLayer!
    // keyframe
    var keyframePath: CAKeyframeAnimation!
    var keyframeBackground: CAKeyframeAnimation!
    var animationTransfrom: CABasicAnimation!
    
    // group
    var groupAnimation: CAAnimationGroup!
    
    convenience init(withView view: UIView, title: String) {
        self.init(frame: view.bounds)
        
        self.containerView = view
        self.title = title
        
        initCommon()
        initCircle()
        initAnimation()
    }
}

extension FeRollingLoader {
    
    func initCommon() {
        self.backgroundColor = UIColor(hexStr: "FEEADF")
    }
    
    func initCircle() {
        // circle
        circleLayer = CAShapeLayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: kFe_Circle_Width, height: kFe_Circle_Width)
        circleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circleLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        // shape
        let length: CGFloat = kFe_Circle_Width / 2
        let path = pathForCornerRectWithRadius(topLeft: 0.85 * length, topRight: 0.95 * length, bottomLeft: 0.85 * length, bottomRight: 0.95 * length)
        circleLayer.path = path
        circleLayer.masksToBounds = true
        circleLayer.fillColor = UIColor(hexStr: kFe_Color_DarkShalmon).cgColor
        self.layer.addSublayer(circleLayer)
    }
    
    func initAnimation() {
        let length = kFe_Circle_Width / 2
        // paths
        let path_0   = pathForCornerRectWithRadius(topLeft: 0.65 * length, topRight: 0.85 * length, bottomLeft: 0.85 * length, bottomRight: 0.65 * length)
        let path_25  = pathForCornerRectWithRadius(topLeft: 0.75 * length, topRight: 0.85 * length, bottomLeft: 0.85 * length, bottomRight: 0.75 * length)
        let path_50  = pathForCornerRectWithRadius(topLeft: 0.95 * length, topRight: 0.75 * length, bottomLeft: 0.75 * length, bottomRight: 0.95 * length)
        let path_75  = pathForCornerRectWithRadius(topLeft: 0.95 * length, topRight: 0.95 * length, bottomLeft: 0.95 * length, bottomRight: 0.95 * length)
        let path_100 = pathForCornerRectWithRadius(topLeft: 0.65 * length, topRight: 0.85 * length, bottomLeft: 0.85 * length, bottomRight: 0.65 * length)
        
        keyframePath = CAKeyframeAnimation(keyPath: "path")
        keyframePath.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        keyframePath.values = [path_0, path_25, path_50, path_75, path_100]
        keyframePath.duration = 1.3
        keyframePath.repeatCount = MAXFLOAT
        
        // background
        keyframeBackground = CAKeyframeAnimation(keyPath: "fillColor")
        keyframeBackground.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        keyframeBackground.values = [UIColor(hexStr: kFe_Color_DarkShalmon).cgColor, UIColor(hexStr: kFe_Color_Salmon).cgColor, UIColor(hexStr: kFe_Color_DarkShalmon).cgColor, UIColor(hexStr: kFe_Color_Salmon).cgColor, UIColor(hexStr: kFe_Color_DarkShalmon).cgColor]
        keyframeBackground.duration = 1.3
        keyframeBackground.repeatCount = MAXFLOAT
        
        // transfrom
        animationTransfrom = CABasicAnimation(keyPath: "transform.rotation")
        animationTransfrom.fromValue = 0.0
        animationTransfrom.toValue = Double.pi * 2
        
        // group
        groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1.3
        groupAnimation.repeatCount = MAXFLOAT
        groupAnimation.animations = [keyframePath, keyframeBackground, animationTransfrom]

    }
    
    private func pathForCornerRectWithRadius(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> CGMutablePath {
        let rect = CGRect(x: 0, y: 0, width: kFe_Circle_Width, height: kFe_Circle_Width)
        
        let refPath = CGMutablePath()
        refPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        refPath.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY), tangent2End: CGPoint(x: rect.midX, y: rect.minY), radius: bottomLeft)
        refPath.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY), tangent2End: CGPoint(x: rect.maxX, y: rect.midY), radius: bottomRight)
        refPath.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY), tangent2End: CGPoint(x: rect.midX, y: rect.maxY), radius: topRight)
        refPath.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY), tangent2End: CGPoint(x: rect.minX, y: rect.midY), radius: topLeft)
        return refPath
    }
}

extension FeRollingLoader {
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true
        circleLayer.add(groupAnimation, forKey: "rolling")
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
