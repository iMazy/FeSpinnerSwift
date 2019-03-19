//
//  FeHourGlassViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/25.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeHourGlassViewController: UIViewController {

    private var hoursGlass: FeHourGlass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.flatWetAsphaltColor
        hoursGlass = FeHourGlass(frame: CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 100, height: 100))
        view.addSubview(hoursGlass)
        
        hoursGlass.showWhileExecutingClosure({
            self.myTask()
        }, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }

    func myTask() {
        // do something usefull in here instead of sleeping...
        sleep(12)
    }
}
