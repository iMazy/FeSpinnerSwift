//
//  FeVietNamBar.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/20.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeVietNamBar: CALayer {
    
    // First, second, third color for animating
    private var firstColor: UIColor = .clear
    private var secondColor: UIColor = .clear
    private var thirdColor: UIColor = .clear
    
    // Group animation
    private var animationGroup: CAAnimationGroup?
    private var indexBar: Int = 0
    
    override init() {
        super.init()
        
    }
    
    convenience init(atInex index: Int, colors: [UIColor]) {
        self.init()
        self.frame = frameAtIndex(index)
        firstColor = colors[0]
        secondColor = colors[1]
        thirdColor = colors[2]
        
        indexBar = index
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        animate()
    }
    
    func stopAnimation() {
        self.removeAllAnimations()
    }
}

extension FeVietNamBar {
    
    func commonInit() {
        backgroundColor = UIColor.clear.cgColor
    }
    
    func frameAtIndex(_ index: Int) -> CGRect {
        var tempFrame: CGRect = .zero
        switch index {
        case 1:
            tempFrame = CGRect(x: 129, y: 36, width: 31, height: 10)
        case 2:
            tempFrame = CGRect(x: 116.5, y: 48, width: 61, height: 10)
        case 3:
            tempFrame = CGRect(x: 84.5, y: 59.5, width: 101, height: 10)
        case 4:
            tempFrame = CGRect(x: 90.5, y: 71.5, width: 112, height: 10)
        case 5:
            tempFrame = CGRect(x: 97.5, y: 84.5, width: 88, height: 10)
        case 6:
            tempFrame = CGRect(x: 123.5, y: 95.5, width: 48, height: 10)
        case 7:
            tempFrame = CGRect(x: 126.5, y: 107.5, width: 39, height: 10)
        case 8:
            tempFrame = CGRect(x: 115.5, y: 119.5, width: 39, height: 10)
        case 9:
            tempFrame = CGRect(x: 128.5, y: 131.5, width: 31, height: 10)
        case 10:
            tempFrame = CGRect(x: 138.5, y: 144.5, width: 26, height: 10)
        case 11:
            tempFrame = CGRect(x: 153.5, y: 155.5, width: 21, height: 10)
        case 12:
            tempFrame = CGRect(x: 162.5, y: 167.5, width: 21, height: 10)
        case 13:
            tempFrame = CGRect(x: 173.5, y: 178.5, width: 21, height: 10)
        case 14:
            tempFrame = CGRect(x: 182.5, y: 190.5, width: 22, height: 10)
        case 15:
            tempFrame = CGRect(x: 188.5, y: 202.5, width: 24, height: 10)
        case 16:
            tempFrame = CGRect(x: 183.5, y: 214.5, width: 34, height: 10)
        case 17:
            tempFrame = CGRect(x: 181.5, y: 226.5, width: 42, height: 10)
        case 18:
            tempFrame = CGRect(x: 184.5, y: 238.5, width: 36, height: 10)
        case 19:
            tempFrame = CGRect(x: 186.5, y: 250.5, width: 37, height: 10)
        case 20:
            tempFrame = CGRect(x: 174.5, y: 262.5, width: 47, height: 10)
        case 21:
            tempFrame = CGRect(x: 153.5, y: 274.5, width: 64, height: 10)
        case 22:
            tempFrame = CGRect(x: 141.5, y: 286.5, width: 69, height: 10)
        case 23:
            tempFrame = CGRect(x: 123.5, y: 298.5, width: 71, height: 10)
        case 24:
            tempFrame = CGRect(x: 127.5, y: 311.5, width: 47, height: 10)
        case 25:
            tempFrame = CGRect(x: 120.5, y: 324.5, width: 38, height: 10)
        case 26:
            tempFrame = CGRect(x: 127.5, y: 336.5, width: 20, height: 10)
        case 27:
            tempFrame = CGRect(x: 266.6, y: 239.5, width: 11, height: 10)
        case 28:
            tempFrame = CGRect(x: 266.5, y: 251.5, width: 25, height: 10)
        case 29:
            tempFrame = CGRect(x: 259.5, y: 262.5, width: 25, height: 10)
        case 30:
            tempFrame = CGRect(x: 236.6, y: 310.5, width: 23, height: 10)
        case 31:
            tempFrame = CGRect(x: 230.5, y: 323.5, width: 22, height: 10)
        default:
            break
        }
        return tempFrame
    }
    
    func animate() {
        animationGroup = animationGroupAtIndex(indexBar)
        add(animationGroup!, forKey: "group")
    }
    
    // Calculator and return CAAnimationGroup for animating
    func animationGroupAtIndex(_ index: Int) -> CAAnimationGroup {
        let group: CAAnimationGroup = CAAnimationGroup()
        switch index {
        case 1, 14:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.66, 0.833, 1]
            colorKeyframe.values = [firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.0, 1.0, 1.2, 1.2, 1.2, 1.2, 1.0]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 2, 15:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.0, 1.2, 1.2, 1.2, 1.2, 1.0, 1.0]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 3, 16:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.2, 1.2, 1.0, 1.0, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 4, 17:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.2, 1.0, 1.0, 1.2, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 5, 18, 27:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.0, 1.0, 1.2, 1.2, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 6, 19, 28:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.0, 1.0, 1.2, 1.2, 1.2, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 7, 20, 29:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.0, 1.0, 1.2, 1.2, 1.2, 1.2, 1.0]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 8, 21:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.0, 1.2, 1.2, 1.2, 1.2, 1.0, 1.0]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 9, 22:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.2, 1.2, 1.0, 1.0, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 10, 23:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, thirdColor.cgColor, thirdColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.2, 1.0, 1.0, 1.0, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 11, 24, 30:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [thirdColor.cgColor, thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.2, 1.0, 1.0, 1.0, 1.2, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 12, 25, 31:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [thirdColor.cgColor, firstColor.cgColor, firstColor.cgColor, secondColor.cgColor, secondColor.cgColor, thirdColor.cgColor, thirdColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.2, 1.0, 1.0, 1.0, 1.2, 1.2, 1.2]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        case 13, 26:
            let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            colorKeyframe.values = [firstColor.cgColor,
                                    firstColor.cgColor,
                                    secondColor.cgColor,
                                    secondColor.cgColor,
                                    thirdColor.cgColor,
                                    thirdColor.cgColor,
                                    firstColor.cgColor]
            colorKeyframe.duration = 3.0
            colorKeyframe.repeatCount = MAXFLOAT
            
            let transformKeyframe = CAKeyframeAnimation(keyPath: "transform.scale.x")
            transformKeyframe.keyTimes = [0, 0.1667, 0.333, 0.5, 0.667, 0.833, 1]
            transformKeyframe.values = [1.0, 1.0, 1.0, 1.2, 1.2, 1.2, 1.0]
            transformKeyframe.duration = 3.0
            transformKeyframe.repeatCount = MAXFLOAT
            
            group.duration = 3.0
            group.timingFunction = CAMediaTimingFunction(name: .linear)
            group.repeatCount = MAXFLOAT
            group.animations = [colorKeyframe, transformKeyframe]
        default:
            break
        }
        return group
    }
}
