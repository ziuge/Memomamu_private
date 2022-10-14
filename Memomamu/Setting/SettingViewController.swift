//
//  SettingViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/12.
//

import UIKit

class SettingViewController: BaseViewController {
    
    var logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame"))
        return view
    }()
    
    var tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        <#code#>
    }
    
    override func setConstraints() {
        <#code#>
    }
    
}
