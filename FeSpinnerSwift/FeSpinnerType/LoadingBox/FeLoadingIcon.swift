//
//  FeLoadingIcon.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/19.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit


protocol FeLoadingIconDelegate {
    func feLoadingIconWillShow(_ sender: FeLoadingIcon)
    func feLoadingIconDidShow(_ sender: FeLoadingIcon)
    func feLoadingIconDidDismiss(_ sender: FeLoadingIcon)
}

class FeLoadingIcon: UIView {

    var kDurationPerColor: Double = 2.0
    
    var isAnimating: Bool = false
    var delegate: FeLoadingIconDelegate?
    var containerView: UIView!
    var bigBoxView: UIView!
    var backgroundStatic: UIView!
    var boxArray: [FeLoadingIconBox] = []
    var colorArray: [UIColor] = []
    var timer: Timer?
    
    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with view: UIView, backgroundColors colorArray:  [UIColor]) {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        self.init(frame: frame)
        
        containerView = view
        initBackgroundView()
        commitInit()
        initColor()
        initBox()
    }
    
    func show() {
        if isAnimating {
            return
        }
        isHidden = false
        alpha = 0
        self.insertSubview(backgroundStatic, at: 0)
        delegate?.feLoadingIconWillShow(self)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.isAnimating = true
            self.delegate?.feLoadingIconDidShow(self)
            self.animateColor()
            
            UIView.animate(withDuration: TimeInterval(self.delayAtIndex(0)), animations: {
                self.bigBoxView.alpha = 1
            })
            
            for i in 1...16 {
                let box = self.boxArray[i-1]
                let delay = self.delayAtIndex(i)
                
                box.perform(#selector(box.startAnimate), with: nil, afterDelay: TimeInterval(delay))
            }
        })
    }
    

    func dismiss() {
        
        if !self.isAnimating {
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.bigBoxView.layer.removeAllAnimations()
            
            for i in 1...16 {
                let box = self.boxArray[i-1]
                box.stopAnimate()
            }
            
            self.delegate?.feLoadingIconDidDismiss(self)
            
            self.removeFromSuperview()
            
            self.isAnimating = false
        })
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
        Thread.detachNewThreadSelector(#selector(executeSelector), toTarget: self, with: nil)
    }

}

extension FeLoadingIcon {
    
    func commitInit() {
        isHidden = true
        alpha = 0
    }
    
    func initBackgroundView() {
        backgroundStatic = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        backgroundStatic?.isUserInteractionEnabled = false
        backgroundStatic?.backgroundColor = UIColor.flatCarrotColor
    }
    
    func initBox() {
        // init big box
        bigBoxView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        bigBoxView.center = self.center
        bigBoxView.layer.cornerRadius = 40
        bigBoxView.clipsToBounds = true
        bigBoxView.alpha = 0
        addSubview(bigBoxView)
        
        // init small boxs
        for i in 1...16 {
            let box = FeLoadingIconBox(boxAtIndex: i)
            bigBoxView.addSubview(box)
            boxArray.append(box)
        }
    }
    
    func initColor() {
        colorArray = [UIColor.flatWisteriaColor, UIColor.flatSunFlowerColor, UIColor.flatPumpkinColor, UIColor.flatGreenSeaColor, UIColor.flatMidNightColor, UIColor.flatWisteriaColor]
    }
    
    func animateColor() {
        let allDuration = kDurationPerColor * Double(colorArray.count)
        UIView.animateKeyframes(withDuration: allDuration, delay: 0, options: [.autoreverse, .repeat], animations: {
            for i in 0..<self.colorArray.count {
                let percentStartTime = self.kDurationPerColor * Double(i) / allDuration
                let percentDuration = self.kDurationPerColor / allDuration
                // add keyframe
                UIView.addKeyframe(withRelativeStartTime: percentStartTime, relativeDuration: percentDuration, animations: {
                    self.bigBoxView.backgroundColor = self.colorArray[i]
                })
            }
        }, completion: { _ in
            
        })
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
    
    @objc func executeSelector() {
        targetForExecuting?.perform(methodForExecuting, with: objectForExecuting)
        
        DispatchQueue.main.async {
            self.completionClosure?()
            self.perform(#selector(self.cleanUp), on: .main, with: nil, waitUntilDone: false)
        }
    }
    
    func delayAtIndex(_ index: Int) -> Double {
        var delay: Double = 0
        switch index {
        case 1:
            delay = 0.55
        case 2:
            delay = 0.5
        case 3:
            delay = 0.45
        case 4:
            delay = 0.4
        case 8:
            delay = 0.35
        case 12:
            delay = 0.3
        case 16:
            delay = 0.25
        case 15:
            delay = 0.2
        case 14:
            delay = 0.15
        case 13:
            delay = 0.1
        case 9:
            delay = 0.5
        case 5:
            delay = 0.0
        case 6:
            delay = 0.0
        case 7:
            delay = 0.18
        case 10:
            delay = 0.36
        case 11:
            delay = 0.55
        default:
            break
        }
        return delay
    }
}
