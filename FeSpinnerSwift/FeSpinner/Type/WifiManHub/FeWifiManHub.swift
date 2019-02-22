//
//  FeWifiManHub.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/22.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

enum FeWifiManHubMode {
    case onlyLoader
    case onlyPercent
}

class FeWifiManHub: UIView {
    
    static let kFe_WifiMan_Width: CGFloat = 85.0
    static let kFe_WifiMan_Height: CGFloat = 85.0
    
    private var targetForExecuting: NSObject?
    private var methodForExecuting: Selector?
    private var objectForExecuting: NSObject?
    private var completionClosure: (()->Void)?
    
    var isAnimating: Bool = false
    var percent: CGFloat = 0 {
        didSet {
            if percent < 0 || percent > 1 || currentMode != .onlyPercent {
                return
            }
            DispatchQueue.main.async {
                let delta = self.percent * FeWifiManHub.kFe_WifiMan_Height
                self.maskLayer?.position = CGPoint(x: 0, y: FeWifiManHub.kFe_WifiMan_Height - delta)
            }
        }
    }
    var currentMode: FeWifiManHubMode = .onlyLoader
    
    var coloredImageView: UIImageView!
    var grayScaleImageView: UIImageView!
    var contentLayer: CALayer?
    
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    // mask
    var maskLayer: CALayer?
    
    // window
    var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    convenience init(withView view: UIView, mode: FeWifiManHubMode) {
        self.init(frame: .zero)
        
        containerView = view
        self.frame = CGRect(x: 0, y: 0, width: 181, height: 147)
        self.center = view.center
        currentMode = mode
        
        self.isHidden = true
        
        initCommon()
        initTitle()
        
        if currentMode == .onlyPercent {
            initWifiManImageView()
            initMaskLayer()
        } else {
            initWifiManHub()
        }
    }
    
    func show() {
        if isAnimating {
            return
        }
        isAnimating = true
        self.isHidden = false
        
        let anim = CAKeyframeAnimation(keyPath: "contents")
        
        let times: [NSNumber] = [NSNumber(value: 0.0), NSNumber(value: 0.25), NSNumber(value: 0.5), NSNumber(value: 0.75), NSNumber(value: 1.0)]
        anim.keyTimes = times
        
        let image_1 = UIImage(named: "WifiMan_Sign_1")!.cgImage!
        let image_2 = UIImage(named: "WifiMan_Sign_2")!.cgImage!
        let image_3 = UIImage(named: "WifiMan_Sign_3")!.cgImage!
        let image_4 = UIImage(named: "WifiMan_Sign_4")!.cgImage!
        anim.values = [image_1, image_2, image_3, image_4]
        anim.duration = 3.0
        anim.repeatCount = MAXFLOAT
        contentLayer?.add(anim, forKey: "content")
    }
    
    func dismiss() {
        if !isAnimating {
            return
        }
        isAnimating = false
        self.removeFromSuperview()
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

extension FeWifiManHub {
    
    func initCommon() {
        backgroundColor = UIColor(white: 0, alpha: 0.8)
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    func initWifiManImageView() {

        let frame = CGRect(x: 48, y: 12, width: FeWifiManHub.kFe_WifiMan_Width, height: FeWifiManHub.kFe_WifiMan_Height)
        let coloredImage = UIImage(named: "wifimanhub")
        let grayImage = UIImage(named: "wifimanhub_grayscale")
        
        self.coloredImageView = UIImageView(frame: frame)
        self.coloredImageView.image = coloredImage
        
        grayScaleImageView = UIImageView(frame: frame)
        grayScaleImageView.image = grayImage
        
        addSubview(grayScaleImageView)
        addSubview(coloredImageView)
    }
    
    func initMaskLayer() {
        
        maskLayer = CALayer()
        maskLayer?.frame = CGRect(x: 0, y: 0, width: FeWifiManHub.kFe_WifiMan_Width, height: FeWifiManHub.kFe_WifiMan_Height)
        maskLayer?.backgroundColor = UIColor.white.cgColor
        maskLayer?.anchorPoint = CGPoint.zero
        maskLayer?.position = CGPoint(x: 0, y: FeWifiManHub.kFe_WifiMan_Height)
        
        coloredImageView.layer.mask = maskLayer
    }
    
    func initTitle() {
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 88, width: 181, height: 31))
        titleLabel.text = "flaying"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: 110, width: 181, height: 31))
        subTitleLabel.text = "the bast revorse is mass success"
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel.backgroundColor = .clear
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = UIColor.white
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    func initWifiManHub() {
        
        let frame = CGRect(x: 48, y: 12, width: FeWifiManHub.kFe_WifiMan_Width, height: FeWifiManHub.kFe_WifiMan_Height)
        let coloredImage = UIImage(named: "WifiMan_Sign_1")
        
        contentLayer = CALayer()
        contentLayer?.frame = frame
        contentLayer?.backgroundColor = UIColor.clear.cgColor
        contentLayer?.contents = coloredImage?.cgImage
        self.layer.addSublayer(contentLayer!)
    }
}
