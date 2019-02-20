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
    var title: String = ""
    var titleFont: UIFont?
    
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
        
    }
    
    func dismiss() {
        
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
        
    }
    
    func initBackground() {
        
    }
    
    func initVietNamBars() {
        
    }
    
    func initLabel() {
        
    }
    
    func resetLabel() {
        
    }
    
    @objc func executingMethod() {
        
    }
    
    @objc func cleanUp() {
        
    }
}
