//
//  FeLoadingBoxViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/19.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeLoadingBoxViewController: UIViewController {

    var loadingIcon: FeLoadingIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexStr: "019875")
        
        loadingIcon = FeLoadingIcon(with: self.view, backgroundColors: [])
        view.addSubview(loadingIcon)
        
        loadingIcon.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }

    func myTask() {
        sleep(6)
    }
}
