//
//  TenDotViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/18.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class TenDotViewController: UIViewController {

    var spinner: FeSpinnerTenDot!
    var titleArray: [String] = []
    var timer: Timer?
    private var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexStr: "019875")
        titleArray = ["LOADING", "PLZ WAITING", "CALM DOWN", "SUCCESSFUL"]
        
        spinner = FeSpinnerTenDot(frame: CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 100, height: 100))
        spinner.titleLabelText = titleArray[index]
        spinner.backgroundColor = .green
        spinner.titleLabelFont = UIFont.systemFont(ofSize: 36)
        spinner.delegate = self
        view.addSubview(spinner)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        start()
        
        self.perform(#selector(dismissed), with: nil, afterDelay: 7.0)
    }
    
    func start() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTitle), userInfo: nil, repeats: true)

        spinner.showWhileExecutingSelector(#selector(longTask), onTarget: self, withObject: nil) {
            self.timer?.invalidate()
            self.timer = nil
            self.index = 0
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func longTask() {
        sleep(5)
    }
    
    @objc func dismissed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func changeTitle() {
        
        print("index = \(index)")
        
        if index >= titleArray.count {
            return
        }
        
        spinner.titleLabelText = titleArray[index]
        index += 1
    }
}

extension TenDotViewController: FeSpinnerTenDotDelegate {
    
    func feSpinnerTenDotWillShow(_ sender: FeSpinnerTenDot) {
        
    }
    
    func feSpinnerTenDotDidShow(_ sender: FeSpinnerTenDot) {
        
    }
    
    func feSpinnerTenDotDidDismiss(_ sender: FeSpinnerTenDot) {
        
    }
}
