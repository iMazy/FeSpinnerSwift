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
        
        view.backgroundColor = UIColor.flatWetAsphaltColor
        equalizer = FeEqualizeView(frame: CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 100, height: 100))
//        equalizer.title = "Loading"
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
