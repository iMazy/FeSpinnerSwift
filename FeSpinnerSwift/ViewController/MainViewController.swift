//
//  MainViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/3/19.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tenDotView: FeSpinnerTenDot!
    @IBOutlet weak var loadingIconView: FeLoadingIcon!
    @IBOutlet weak var threeDotView: FeThreeDotGlow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tenDotView.show()
        
        loadingIconView.show()
        
        threeDotView.show()
    }
}
