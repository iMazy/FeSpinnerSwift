//
//  FeThreeDotGlow.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/21.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeThreeDotGlow: UIView {

    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    var isShowing: Bool = false
    
    private var containerView: UIView!
    private var containerDotLayer: CALayer!
    private var threeDots: [CALayer] = []
    private var rotateAnimation: CABasicAnimation!
    private var glowAnimation: CAKeyframeAnimation!
    private var colorGlowAnimation: CAKeyframeAnimation!
    private var colorDotAnimation: CAKeyframeAnimation!
    private var groupAnimation: CAAnimationGroup!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(withView view: UIView) {
        self.init(frame: view.bounds)
        
        containerView = view
        
        commonInit()
        initBackground()
        initThreeDot()
        initAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true
        
        containerDotLayer.add(rotateAnimation, forKey: "transform.rotation")
        
        for dot in threeDots {
            dot.add(groupAnimation, forKey: "shadowRadius")
        }
    }
    
    func dismiss() {
        if !isShowing {
            return
        }
        isShowing = false

        // Remove all animations
        for dot in threeDots {
            dot.removeAllAnimations()
        }
        containerDotLayer.removeAllAnimations()
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

extension FeThreeDotGlow {
    
    func commonInit() {
        //
    }
    
    func initBackground() {
        backgroundColor = UIColor.flatWetAsphaltColor
    }
    
    func initThreeDot() {
        
        containerDotLayer = CALayer()
        containerDotLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        containerDotLayer.backgroundColor = UIColor.clear.cgColor
        containerDotLayer.position = self.center
        
        for i in 0..<3 {
            let dot = CALayer()
            var tempFrame: CGRect = .zero
            
            switch i {
            case 0:
                tempFrame = CGRect(x: 15, y: 0, width: 20, height: 20)
            case 1:
                tempFrame = CGRect(x: 0, y: 29.5, width: 20, height: 20)
            case 2:
                tempFrame = CGRect(x: 30.5, y: 29.5, width: 20, height: 20)
            default:
                break
            }
            
            dot.frame = tempFrame
            dot.backgroundColor = UIColor.flatCarrotColor.cgColor
            dot.cornerRadius = 10
            dot.shadowColor = UIColor.flatCarrotColor.cgColor
            dot.shadowOpacity = 1
            dot.shadowOffset = CGSize(width: 0, height: 0)
            dot.shadowRadius = 15
            
            containerDotLayer.addSublayer(dot)
            threeDots.append(dot)
        }
        self.layer.addSublayer(containerDotLayer)
    }
    
    func initAnimations() {
        
        rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.repeatCount = MAXFLOAT
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = Double.pi * 2
        rotateAnimation.duration = 1.5
        
        glowAnimation = CAKeyframeAnimation(keyPath: "shadowRadius")
        glowAnimation.keyTimes = [0.0, 0.5, 1.0]
        glowAnimation.values = [5.0, 20.0, 5.0]
        glowAnimation.repeatCount = MAXFLOAT
        glowAnimation.duration = 1.5
        
        colorGlowAnimation = CAKeyframeAnimation(keyPath: "shadowColor")
        colorGlowAnimation.keyTimes = [0.0, 0.5, 1.0]
        colorGlowAnimation.values = [UIColor(hexStr: "ff0000").cgColor, UIColor(hexStr: "00ff00").cgColor, UIColor(hexStr: "ff0000").cgColor]
        colorGlowAnimation.repeatCount = MAXFLOAT
        colorGlowAnimation.duration = 1.5
        
        colorDotAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorDotAnimation.keyTimes = [0.0, 0.5, 1.0]
        colorDotAnimation.values = [UIColor(hexStr: "ff0000").cgColor, UIColor(hexStr: "00ff00").cgColor, UIColor(hexStr: "ff0000").cgColor]
        colorDotAnimation.repeatCount = MAXFLOAT
        colorDotAnimation.duration = 1.5
        
        groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1.5
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        groupAnimation.repeatCount = MAXFLOAT
        groupAnimation.animations = [glowAnimation, colorDotAnimation, colorGlowAnimation]
    }
}
