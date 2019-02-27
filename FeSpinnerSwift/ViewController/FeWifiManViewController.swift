//
//  FeWifiManViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/22.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeWifiManViewController: UIViewController {

    var  wifiManHubLoader: FeWifiManHub?
    var  wifiManHubPercent: FeWifiManHub?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []
        
        view.backgroundColor = UIColor.flatWetAsphaltColor
        
        wifiManHubLoader = FeWifiManHub(withView: self.view, mode: .onlyLoader)
        self.view.addSubview(wifiManHubLoader!)
        
        wifiManHubLoader?.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.setTitle("change mode", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(changeModeOfWifiMan), for: .touchUpInside)
        button.titleLabel?.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

    }
    
    @objc func changeModeOfWifiMan() {
        
        wifiManHubPercent = FeWifiManHub(withView: self.view, mode: .onlyPercent)
        wifiManHubLoader?.removeFromSuperview()
        self.view.addSubview(wifiManHubPercent!)
        wifiManHubPercent?.showWhileExecutingClosure({
            self.myProgressTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }

    func myTask() {
        sleep(6)
    }
    
    func stopLoader() {
        
    }
    
    func myProgressTask() {
        
        var progress: CGFloat = 0.0
        while progress < 1.0 {
            progress += 0.01
            wifiManHubPercent?.percent = progress
            usleep(30000)
        }
    }
}
