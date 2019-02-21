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
        
        threeDot = FeThreeDotGlow(withView: self.view)
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
