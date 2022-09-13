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
        view.setImage(UIImage(named: "todayButton.jpg"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.text
        view.text = "17, April"
        view.font = Constants.Font.head
        view.backgroundColor = .brown
        return view
    }()
    
    var paperView: UIView = {
        let view = WriteView()
        
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
    
    let vc = PageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        
        configure()
        setConstraints()
        addPageVC()
    }
    
    func configure() {
        [viewButton, dateLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        viewButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.height.width.equalTo(21)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(97)
            make.centerX.equalTo(view)
            
        }
        
    }
    
    func addPageVC() {
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.topMargin.equalTo(dateLabel.snp.bottom).offset(66)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.63)
        }
        
    }
    
}

extension WriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

