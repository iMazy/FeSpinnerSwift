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

    var isAnimating: Bool = false
    var delegate: FeLoadingIconDelegate?
    var containerView: UIView!
    var bigBoxView: UIView!
    var backgroundStatic: UIView?
    var boxArray: [UIView] = []
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
        commitInit()
        self.colorArray = colorArray
        initBox()
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

extension FeLoadingIcon {
    
    func commitInit() {
        isHidden = true
        alpha = 0
    }
    
    func initBackgroundView() {
        backgroundStatic = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        backgroundStatic?.isUserInteractionEnabled = false
        backgroundStatic?.backgroundColor = UIColor(r: 230/255.0, g: 126/255.0, b: 34/255.0)
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
        for i in 0..<16 {
//            let bix = 
        }
    }
    
    
    func initColor() {
        
    }
    
    func animateColor() {
        
    }
    
    func cleanUp() {
        
    }
    
    func executeSelector() {
        
    }
}
