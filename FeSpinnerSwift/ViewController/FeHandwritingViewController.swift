//
//  FeHandwritingViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/3/4.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeHandwritingViewController: UIViewController {

    var handwritingLoader: FeHandwritingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexStr: "ffe200")
        
        handwritingLoader = FeHandwritingView(withView: self.view)
        view.addSubview(handwritingLoader)
        
        handwritingLoader.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func myTask() {
        sleep(6)
    }

}
