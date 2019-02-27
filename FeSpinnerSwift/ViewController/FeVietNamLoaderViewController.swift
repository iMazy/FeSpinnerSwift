//
//  FeVietNamLoaderViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/21.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class FeVietNamLoaderViewController: UIViewController {

    private var vietNamLoader: FeVietNamLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []

        view.backgroundColor = .white
        
        vietNamLoader = FeVietNamLoader(withView: self.view, colors: [])
        view.addSubview(vietNamLoader)
        
        vietNamLoader.showWhileExecutingClosure({
            self.myTask()
        }) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func myTask() {
        sleep(6)
    }
}
