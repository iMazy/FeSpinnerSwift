//
//  FeThreeDotGlowViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/21.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeThreeDotGlowViewController: UIViewController {

    private var threeDot: FeThreeDotGlow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.flatWetAsphaltColor
        
        threeDot = FeThreeDotGlow(frame: CGRect(x: (view.bounds.width - 50) / 2, y: (view.bounds.height - 50) / 2, width: 50, height: 50))
        view.addSubview(threeDot)
        
        threeDot.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }

    func myTask() {
        sleep(6)
    }
}
