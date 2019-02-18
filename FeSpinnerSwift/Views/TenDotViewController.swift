//
//  TenDotViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/18.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class TenDotViewController: UIViewController {

    lazy var spinner: FeSpinnerTenDot = FeSpinnerTenDot(view: self.view, withBlur: false)
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexStr: "019875")
        
        spinner.titleLabelText = "LOADING"
        spinner.titleLabelFont = UIFont.systemFont(ofSize: 36)
        spinner.delegate = self
        view.addSubview(spinner)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        start()
    }
    
    func start() {
        spinner.showWhileExecutingSelector(#selector(longTask), onTarget: self, withObject: nil) {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func longTask() {
        sleep(5)
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
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
