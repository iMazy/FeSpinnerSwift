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
        
        view.backgroundColor = UIColor.flatWetAsphaltColor
        rollingLoader = FeRollingLoader(frame: CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 100, height: 100))
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
