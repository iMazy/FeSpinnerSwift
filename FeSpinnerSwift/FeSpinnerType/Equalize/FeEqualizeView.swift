//
//  FeEqualizeView.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/26.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeEqualizeView: UIView {

    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    private let kFe_Equalize_Width: CGFloat = 100.0
    private let kFe_Equalize_Height: CGFloat = 50.0
    private let kFe_Equalize_Bar_Width: CGFloat = 20.0
    private let kFe_Equalize_Bar_Height: CGFloat = 50.0
    
    var isShowing: Bool = false
    var title: String?
    
    // container view
    var containerView: UIView!
    var containerLayer: CALayer!
    // bars
    var firstBar: CAShapeLayer!
    var secondBar: CAShapeLayer!
    var thirdBar: CAShapeLayer!
    var fourthBar: CAShapeLayer!
    var fifthBar: CAShapeLayer!
    // bizier path
    var originalBezierPath: UIBezierPath!
    var endBezierPath: UIBezierPath!
    
    // animation
    var firstAnimation: CABasicAnimation!
    var secondAnimation: CABasicAnimation!
    var thirdAnimation: CABasicAnimation!
    var fourthAnimation: CABasicAnimation!
    var fifthAnimation: CABasicAnimation!
    
    var titleLabel: UILabel!
    
    convenience init(withView view: UIView, title: String) {
        self.init(frame: view.bounds)
        
        self.title = title
        self.containerView = view
        
        initCommon()
        initContainerLayer()
        initBezierPath()
        initBars()
        initTitle()
        initAnimation()
    }
}

extension FeEqualizeView {
    
    func initCommon() {
        self.backgroundColor = UIColor(hexStr: "141517")
    }
    
    func initContainerLayer() {
        containerLayer = CALayer()
        containerLayer.backgroundColor = UIColor.clear.cgColor
        containerLayer.frame = CGRect(x: 0, y: 0, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
        containerLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        containerLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        self.layer.addSublayer(containerLayer)
    }
    
    func initBars() {
        for i in 0..<5 {
            let origin = CGPoint(x: kFe_Equalize_Bar_Width * CGFloat(i), y: 0)
            switch i {
            case 0:
                firstBar = CAShapeLayer()
                firstBar.frame = CGRect(x: origin.x, y: origin.y, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
                firstBar.path = originalBezierPath.cgPath
                firstBar.fillColor = UIColor(hexStr: "0B486B").cgColor
                containerLayer.addSublayer(firstBar)
            case 1:
                secondBar = CAShapeLayer()
                secondBar.frame = CGRect(x: origin.x, y: origin.y, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
                secondBar.path = originalBezierPath.cgPath
                secondBar.fillColor = UIColor(hexStr: "3B8686").cgColor
                containerLayer.addSublayer(secondBar)
            case 2:
                thirdBar = CAShapeLayer()
                thirdBar.frame = CGRect(x: origin.x, y: origin.y, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
                thirdBar.path = originalBezierPath.cgPath
                thirdBar.fillColor = UIColor(hexStr: "79BD9A").cgColor
                containerLayer.addSublayer(thirdBar)
            case 3:
                fourthBar = CAShapeLayer()
                fourthBar.frame = CGRect(x: origin.x, y: origin.y, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
                fourthBar.path = originalBezierPath.cgPath
                fourthBar.fillColor = UIColor(hexStr: "A8DBA8").cgColor
                containerLayer.addSublayer(fourthBar)
            case 4:
                fifthBar = CAShapeLayer()
                fifthBar.frame = CGRect(x: origin.x, y: origin.y, width: kFe_Equalize_Width, height: kFe_Equalize_Height)
                fifthBar.path = originalBezierPath.cgPath
                fifthBar.fillColor = UIColor(hexStr: "CFF09E").cgColor
                containerLayer.addSublayer(fifthBar)
            default:
                break
            }
        }
    }
    
    func initBezierPath() {
        originalBezierPath = UIBezierPath()
        originalBezierPath.move(to: CGPoint(x: 0, y: kFe_Equalize_Bar_Height))
        originalBezierPath.addLine(to: CGPoint(x: kFe_Equalize_Bar_Width / 2, y: kFe_Equalize_Bar_Height - 2.0))
        originalBezierPath.addLine(to: CGPoint(x: kFe_Equalize_Bar_Width, y: kFe_Equalize_Bar_Height))
        originalBezierPath.addLine(to: CGPoint(x: 0, y: kFe_Equalize_Bar_Height))
        originalBezierPath.close()
        
        // end path
        endBezierPath = UIBezierPath()
        endBezierPath.move(to: CGPoint(x: 0, y: kFe_Equalize_Bar_Height))
        endBezierPath.addLine(to: CGPoint(x: kFe_Equalize_Bar_Width / 2, y: 0))
        endBezierPath.addLine(to: CGPoint(x: kFe_Equalize_Bar_Width, y: kFe_Equalize_Bar_Height))
        endBezierPath.addLine(to: CGPoint(x: 0, y: kFe_Equalize_Bar_Height))
        endBezierPath.close()
    }
    
    func initTitle() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexStr: "CFF09E")
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: bounds.size.width / 2, y: containerLayer.frame.origin.y - containerLayer.frame.height + 16)
        self.addSubview(titleLabel)
    }
    
    func initAnimation() {
        
        func createPathAnimation() -> CABasicAnimation {
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = originalBezierPath.cgPath
            animation.toValue = endBezierPath.cgPath
            animation.autoreverses = true
            animation.duration = 0.5
            animation.repeatCount = MAXFLOAT
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
            return animation
        }
        
        // animations
        firstAnimation  = createPathAnimation()
        secondAnimation = createPathAnimation()
        thirdAnimation  = createPathAnimation()
        fourthAnimation = createPathAnimation()
        fifthAnimation  = createPathAnimation()
    }
}

extension FeEqualizeView {
    
    func show() {
        if isShowing {
            return
        }
        isShowing = true

        self.perform(#selector(addFirstAnimation), with: nil, afterDelay: 0)
        self.perform(#selector(addSecondAnimation), with: nil, afterDelay: 0.1)
        self.perform(#selector(addThirdAnimation), with: nil, afterDelay: 0.2)
        self.perform(#selector(addFourthAnimation), with: nil, afterDelay: 0.3)
        self.perform(#selector(addFifthAnimation), with: nil, afterDelay: 0.4)
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
    
    @objc func addFirstAnimation() {
        firstBar.add(firstAnimation, forKey: "firstAnimation")
    }
    
    @objc func addSecondAnimation() {
        secondBar.add(secondAnimation, forKey: "secondAnimation")
    }
    
    @objc func addThirdAnimation() {
        thirdBar.add(thirdAnimation, forKey: "thirdAnimation")
    }
    
    @objc func addFourthAnimation() {
        fourthBar.add(fourthAnimation, forKey: "fourthAnimation")
    }
    
    @objc func addFifthAnimation() {
        fifthBar.add(fifthAnimation, forKey: "fifthAnimation")
    }
}
