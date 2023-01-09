//
//  BaseViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/14.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        
        configure()
        setConstraints()
    }
    
    func configure() { }
    func setConstraints() { }
    
}
