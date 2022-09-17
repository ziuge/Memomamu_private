//
//  SortViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit

class SortViewController: UIViewController {
    
    var viewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todayButton.jpg"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
    
    var calendarButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "square"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure() {
        
    }
    
    func setConstraints() {
        
    }
    
}

extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
