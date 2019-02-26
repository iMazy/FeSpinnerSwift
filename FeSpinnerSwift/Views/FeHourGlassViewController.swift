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

        hoursGlass = FeHourGlass(withView: self.view)
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
