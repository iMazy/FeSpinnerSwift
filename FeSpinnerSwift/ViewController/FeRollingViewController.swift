//
//  FeRollingViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/28.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeRollingViewController: UIViewController {

    private var rollingLoader: FeRollingLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rollingLoader = FeRollingLoader(withView: self.view, title: "Loading")
        view.addSubview(rollingLoader)
        
        rollingLoader.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func myTask() {
        sleep(6)
    }
}
