//
//  FeTenDot.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/17.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeTenDot: UIView {

    static var kMargeCenterX: CGFloat = 10
    static var kMargeCenterY: CGFloat = 10
    static var kDurationDot: Double = 0.15
    
    var originalTransform3D: CATransform3D!
    // Timer
    private var timer: Timer?
    private var isAnimating: Bool = false
    
    // Main View
    private var mainView: UIView!
    private var indexDot: Int = 0
    private var originCenter: CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(mainView: UIView, atIndex index: Int) {
        
        let frame = CGRect(x: mainView.center.x, y: mainView.center.y, width: 20, height: 20)
        self.init(frame: frame)
        
        // Deafault
        self.backgroundColor = .white
        self.layer.cornerRadius = self.bounds.size.width / 2;
        self.clipsToBounds = true
        self.mainView = mainView
        self.indexDot = index
        
        self.center = centerAtIndex(index)
        self.originCenter = self.center
        
        self.originalTransform3D = transform3DAtIndex(index)
        self.layer.transform = self.originalTransform3D
        
        self.isUserInteractionEnabled = false
    }
    
//    func initDotAtMainView(_ mainView: UIView, atIndex index: Int) {
//    }
//

    @objc func start() {
        if isAnimating {
            return
        }
        if !isAnimating {
            isAnimating = true
            animate()
            timer = Timer.scheduledTimer(timeInterval: 2.7, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        }
    }
    
    func stop() {
        if (timer == nil || !isAnimating) {
            return
        }
        if timer != nil && isAnimating {
            timer?.invalidate()
            isAnimating = false
        }
    }
    
    func reset() {
        timer?.invalidate()
        layer.transform = CATransform3DIdentity
        self.center = originCenter
        originalTransform3D = transform3DAtIndex(indexDot)
        layer.transform = originalTransform3D
    }

    func centerAtIndex(_  index: Int) -> CGPoint {
        var tempCenter: CGPoint = .zero
        switch index {
        case 0:
            tempCenter = CGPoint(x: self.center.x - 10, y: self.center.y - 10)
        case 1:
            tempCenter = CGPoint(x: self.center.x + 14, y: self.center.y - 43)
        case 2:
            tempCenter = CGPoint(x: self.center.x + 29, y: self.center.y - 24)
        case 3:
            tempCenter = CGPoint(x: self.center.x + 29, y: self.center.y)
        case 4:
            tempCenter = CGPoint(x: self.center.x + 15, y: self.center.y + 22)
        case 5:
            tempCenter = CGPoint(x: self.center.x - 10, y: self.center.y + 30)
        case 6:
            tempCenter = CGPoint(x: self.center.x - 35, y: self.center.y + 22)
        case 7:
            tempCenter = CGPoint(x: self.center.x - 49, y: self.center.y)
        case 8:
            tempCenter = CGPoint(x: self.center.x - 49, y: self.center.y - 24)
        case 9:
            tempCenter = CGPoint(x: self.center.x - 34, y: self.center.y - 43)
        default:
            break
        }
        return tempCenter
    }
    
    func transform3DAtIndex(_ index: Int) -> CATransform3D {
        var t: CATransform3D = CATransform3DIdentity
        switch index {
        case 0:
            t = CATransform3DTranslate(t, 10 - FeTenDot.kMargeCenterX, 50 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 1:
            t = CATransform3DTranslate(t, -14 - FeTenDot.kMargeCenterX, 43 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 2:
            t = CATransform3DTranslate(t, -29 - FeTenDot.kMargeCenterX, 24 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 3:
            t = CATransform3DTranslate(t, -29 - FeTenDot.kMargeCenterX, 0 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 4:
            t = CATransform3DTranslate(t, -15 - FeTenDot.kMargeCenterX, -22 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 5:
            t = CATransform3DTranslate(t, 10 - FeTenDot.kMargeCenterX, -30 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 6:
            t = CATransform3DTranslate(t, 35 - FeTenDot.kMargeCenterX, -22 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 7:
            t = CATransform3DTranslate(t, 49 - FeTenDot.kMargeCenterX, 0 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 8:
            t = CATransform3DTranslate(t, 49 - FeTenDot.kMargeCenterX, 24 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        case 9:
            t = CATransform3DTranslate(t, 34 - FeTenDot.kMargeCenterX, 43 - FeTenDot.kMargeCenterY, 0)
            t = CATransform3DScale(t, 0.1, 0.1, 0.1)
        default:
            break
        }
        return t
    }

    @objc func animate() {
        UIView.animate(withDuration: FeTenDot.kDurationDot, delay: 0, options: .curveEaseOut, animations: {
            self.layer.transform = CATransform3DIdentity
        }) { (_) in
            UIView.animate(withDuration: 0, delay: 1.2, options: .curveEaseOut, animations: {
                self.layer.transform = CATransform3DIdentity
            }) { (_) in
                
            }
        }
    }
}
