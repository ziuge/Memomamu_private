//
//  WriteViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit
import SnapKit
import RealmSwift

class WriteViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var viewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todayButton"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.text
        view.text = "17, April"
        view.font = Constants.Font.head
        return view
    }()
    
    var paperView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        view.register(WriteTableViewCell.self, forCellReuseIdentifier: WriteTableViewCell.reuseIdentifier)
        return view
    }()
    
    var contents: Results<Content>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        [viewButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        viewButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(62)
            make.trailingMargin.equalTo(view).offset(30)
        }
        
    }
    
}

extension WriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

