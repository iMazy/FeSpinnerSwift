//
//  FeSpinnerTenDot.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/17.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

protocol FeSpinnerTenDotDelegate {
    func feSpinnerTenDotWillShow(_ sender: FeSpinnerTenDot)
    func feSpinnerTenDotDidShow(_ sender: FeSpinnerTenDot)
    func feSpinnerTenDotDidDismiss(_ sender: FeSpinnerTenDot)
}


class FeSpinnerTenDot: UIView {
    
    let kMaxTenDot: Int = 10
    let kPagingLabel: CGFloat = 30

    var delegate: FeSpinnerTenDotDelegate?
    var titleLabelText: String = ""
    var titleLabelFont: UIFont?
    
    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    // Background Static for Blur View
    var backgroundStatic: UIView?
    // Array of dot
    var arrDot: [FeTenDot] = []
    // Container View
    var containerView: UIView!
    // Timer
    var timer: Timer?
    // Label
    var label: UILabel?
    // Bool
    var isAnimating: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(view: UIView, withBlur blur: Bool) {
    
        self.init(frame: .zero)
    
        assert(view.bounds.size.height <= 100, "Container view's height shouldn't less than 100")
        containerView = view
        self.isHidden = true
        self.alpha = 0.0
    }
    
    
    private func commonInit() {
        self.frame = containerView.bounds
        
        backgroundStatic = UIView(frame: containerView.bounds)
        backgroundStatic?.backgroundColor = UIColor(hexStr: "32ce55")
        
        initDot()
    }
    
    func initDot() {
        let tempCenter = self.center
        let centerDot = UIView(frame: CGRect(x: tempCenter.x, y: tempCenter.y, width: 20, height: 20))
        centerDot.clipsToBounds = true
        centerDot.layer.cornerRadius = centerDot.bounds.size.height / 2
        centerDot.backgroundColor = .white
        centerDot.center = tempCenter
        
        self.addSubview(centerDot)
        
        for i in 0..<kMaxTenDot {
            let dot = FeTenDot(mainView: self, atIndex: i)
            arrDot.append(dot)
            self.addSubview(dot)
        }
    }
    
    func initLabel() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label?.textColor = .white
        label?.text = titleLabelText
        label?.textAlignment = .center
        label?.sizeToFit()
        label?.center = CGPoint(x: center.x, y: center.y + kPagingLabel + 30 + (label?.bounds.size.height ?? 0) / 2)
        self.addSubview(label!)
    }
    
    func resetLabel() {
        if isAnimating {
            let animation = CATransition()
            animation.duration = 0.8
            animation.type = CATransitionType.fade
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            label?.layer.add(animation, forKey: "changeTextTransition")
            // change text
            label?.font = titleLabelFont
            label?.text = titleLabelText
        } else {
            label?.font = titleLabelFont
            label?.text = titleLabelText
        }
        label?.sizeToFit()
        label?.center = CGPoint(x: center.x, y: center.y + kPagingLabel + 30 + (label?.bounds.size.height ?? 0) / 2)
    }
    
    func setTitleLabelText(_ text: String) {
        if text == titleLabelText {
            return
        }
        titleLabelText = text
        if label == nil {
            initLabel()
        }
        resetLabel()
    }
    
    func setTitleLabelFont(_ font: UIFont) {
        if font == titleLabelFont {
            return
        }
        titleLabelFont = font
        resetLabel()
    }
    
    func show() {
        if isAnimating {
            return
        }
        
        self.isHidden = false
        self.alpha = 1
        
        self.insertSubview(backgroundStatic!, at: 0)
        
        delegate?.feSpinnerTenDotWillShow(self)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
        }) { (_) in
            self.isAnimating = true
            self.delegate?.feSpinnerTenDotWillShow(self)
            var delay: TimeInterval = 0
            for i in 0..<self.kMaxTenDot {
                let dot = self.arrDot[i]
                dot.perform(#selector(dot.start), with: nil, afterDelay: delay)
                delay += 0.1
            }
        }
    }
    
    func dismiss() {
        if !isAnimating {
            return
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0
        }) { (_) in
            for i in 0..<self.kMaxTenDot {
                let dot = self.arrDot[i]
                dot.stop()
                dot.reset()
            }
            self.isAnimating = false
            self.delegate?.feSpinnerTenDotDidDismiss(self)
            self.removeFromSuperview()
            self.cleanUp()
        }
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

    
    // clean up method, target, object
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
    
    // Executing method
    @objc func executingMethod() {
        targetForExecuting?.perform(methodForExecuting, with: objectForExecuting)
        
        DispatchQueue.main.async {
            self.completionClosure?()
            self.perform(#selector(self.cleanUp), on: .main, with: nil, waitUntilDone: false)
        }
    }
}
