//
//  FeLoadingIconBox.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/19.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeLoadingIconBox: UIView {

    var kBoxHeight: CGFloat = 25
    var isAnimating: Bool = false
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithBoxAtIndex(_ index: Int) {
        let tempFrame = self.frameAtIndex(index)
        self.frame = tempFrame
        backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.2)
        isUserInteractionEnabled = false
    }
    
    func startAnimate() {
        if isAnimating {
            return
        }
        animate()
        timer = Timer.scheduledTimer(timeInterval: 0.55, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    func stopAnimate() {
        if !isAnimating {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animate() {
        UIView.animate(withDuration: 0.275, delay: 0, options: .curveLinear, animations: {
            self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.275, delay: 0, options: .curveLinear, animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            }, completion: { _ in
                
            })
        })
    }
    
    func frameAtIndex(_ index: Int) -> CGRect {
        var tempFrame: CGRect = CGRect.zero
        switch index {
        case 1:
            tempFrame = CGRect(x: 0, y: 0, width: kBoxHeight, height: kBoxHeight)
        case 2:
            tempFrame = CGRect(x: 25, y: 0, width: kBoxHeight, height: kBoxHeight)
        case 3:
            tempFrame = CGRect(x: 50, y: 0, width: kBoxHeight, height: kBoxHeight)
        case 4:
            tempFrame = CGRect(x: 75, y: 0, width: kBoxHeight, height: kBoxHeight)
        case 5:
            tempFrame = CGRect(x: 0, y: 25, width: kBoxHeight, height: kBoxHeight)
        case 6:
            tempFrame = CGRect(x: 25, y: 25, width: kBoxHeight, height: kBoxHeight)
        case 7:
            tempFrame = CGRect(x: 50, y: 25, width: kBoxHeight, height: kBoxHeight)
        case 8:
            tempFrame = CGRect(x: 75, y: 25, width: kBoxHeight, height: kBoxHeight)
        case 9:
            tempFrame = CGRect(x: 0, y: 50, width: kBoxHeight, height: kBoxHeight)
        case 10:
            tempFrame = CGRect(x: 25, y: 50, width: kBoxHeight, height: kBoxHeight)
        case 11:
            tempFrame = CGRect(x: 50, y: 50, width: kBoxHeight, height: kBoxHeight)
        case 12:
            tempFrame = CGRect(x: 75, y: 50, width: kBoxHeight, height: kBoxHeight)
        case 13:
            tempFrame = CGRect(x: 0, y: 75, width: kBoxHeight, height: kBoxHeight)
        case 14:
            tempFrame = CGRect(x: 25, y: 75, width: kBoxHeight, height: kBoxHeight)
        case 15:
            tempFrame = CGRect(x: 50, y: 75, width: kBoxHeight, height: kBoxHeight)
        case 16:
            tempFrame = CGRect(x: 75, y: 75, width: kBoxHeight, height: kBoxHeight)
        default:
            break
        }
        return tempFrame
    }
}

extension FeLoadingIconBox {
    func setupAlpahBixAtIndex(_ index: Int) {
        switch index {
        case 6, 7, 10, 11:
            alpha = 0.5
        default:
            break
        }
    }
}
