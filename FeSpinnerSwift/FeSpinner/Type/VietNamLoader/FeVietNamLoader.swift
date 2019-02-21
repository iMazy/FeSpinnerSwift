//
//  FeVietNamLoader.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/20.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeVietNamLoader: UIView {

    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    var lastPosition: CGPoint = .zero
    
    let kCountVietNamBar: Int = 31

    var isAnimating: Bool = false
    var colorsArray: [UIColor] = []
    var title: String = "" {
        didSet {
            resetLabel()
        }
    }
    var titleFont: UIFont? {
        didSet {
            resetLabel()
        }
    }
    
    var container: UIView!
    var backgroundStatic: UIView!
    // array of vietnamBar
    var vietNamBars: [FeVietNamBar] = []
    var label: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withView view: UIView, colors: [UIColor]) {
        self.init(frame: view.frame)
        
        container = view
        if colors.count > 0 {
            colorsArray = colors
        } else {
            colorsArray = [UIColor.flatAlizarinColor, UIColor.flatEmeraldColor, UIColor.flatSunFlowerColor]
        }
        
        container.addSubview(self)
        self.isHidden = true
        self.alpha = 0
        
        commonInit()
        initBackground()
        initVietNamBars()
        initLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        if isAnimating {
            return
        }
        
        isHidden = false
        alpha = 0
        
        self.insertSubview(backgroundStatic, at: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.isAnimating = true
            for bar in self.vietNamBars {
                bar.startAnimation()
            }
        })
    }
    
    func dismiss() {
        if !isAnimating {
            return
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.isAnimating = false
            
            for bar in self.vietNamBars {
                bar.stopAnimation()
            }
            
            self.removeFromSuperview()
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
        Thread.detachNewThreadSelector(#selector(executingMethod), toTarget: self, with: nil)
    }

}

extension FeVietNamLoader {
    
    func commonInit() {
        //
    }
    
    func initBackground() {
        backgroundStatic = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        backgroundStatic.isUserInteractionEnabled = false
        backgroundStatic.backgroundColor = UIColor.flatWetAsphaltColor
    }
    
    func initVietNamBars() {
        for i in 1...kCountVietNamBar {
            let bar = FeVietNamBar(atInex: i, colors: colorsArray)
            self.layer.addSublayer(bar)
            vietNamBars.append(bar)
            
            if i == 26 {
                lastPosition = bar.position
            }
        }
    }
    
    func initLabel() {
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label?.textAlignment = .center
        label?.text = "LOADING"
        label?.font = UIFont.systemFont(ofSize: 36)
        label?.textColor = UIColor.white
        label?.sizeToFit()
        label?.center = CGPoint(x: center.x, y: lastPosition.y + 40)
        
        self.addSubview(label!)
    }
    
    func resetLabel() {
        if isAnimating {
            let animation = CATransition()
            animation.duration = 0.8
            animation.type = .fade
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            label?.layer.add(animation, forKey: "changeTextTransition")
            
            // change text
            label?.font = self.titleFont
            label?.text = self.title
        } else {
            // change text
            label?.font = self.titleFont
            label?.text = self.title
        }
        label?.sizeToFit()
        label?.center = CGPoint(x: center.x, y: lastPosition.y + 40)
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
