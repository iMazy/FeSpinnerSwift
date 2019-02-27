//
//  FeEqualizerViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/27.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeEqualizerViewController: UIViewController {

    private var equalizer: FeEqualizeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        equalizer = FeEqualizeView(withView: self.view, title: "Loading")
        self.view.addSubview(equalizer)
        
        equalizer
            .showWhileExecutingClosure({
                self.myTask()
            }, completion: {
                self.navigationController?.popViewController(animated: true)
            })
    }
    
    func myTask() {
        sleep(6)
    }
}
