//
//  ViewController.swift
//  FeSpinnerSwift
//
//  Created by Mazy on 2019/2/17.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "FeSpinnerSwift"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        dataSource = ["Fe Spinner Ten Dot", "Loading Box", "Viet Nam Loader", "Three Dot Glow", "Wifi Hub", "Hour Glass", "Equalizer", "Rolling", "Handwriting"]
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        switch indexPath.row {
        case 0:
            let tenDotVc = TenDotViewController()
            show(tenDotVc, sender: nil)
        case 1:
            let tenDotVc = FeLoadingBoxViewController()
            show(tenDotVc, sender: nil)
        case 2:
            let vietNamLoaderVC = FeVietNamLoaderViewController()
            show(vietNamLoaderVC, sender: nil)
        case 3:
            let threeDotVC = FeThreeDotGlowViewController()
            show(threeDotVC, sender: nil)
        case 4:
            let wifiManVC = FeWifiManViewController()
            show(wifiManVC, sender: nil)
        case 5:
            let hoursGlassVC = FeHourGlassViewController()
            show(hoursGlassVC, sender: nil)
        case 6:
            let equalizerVC = FeEqualizerViewController()
            show(equalizerVC, sender: nil)
        case 7:
            let rollingVC = FeRollingViewController()
            show(rollingVC, sender: nil)
        case 8:
            let handwritingVC = FeHandwritingViewController()
            show(handwritingVC, sender: nil)
        default:
            break
        }
    }
}

