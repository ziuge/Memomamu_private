//
//  CardTodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class CardTodoViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "to do list"
        view.font = Constants.Font.title
        view.textColor = Constants.Color.background
        return view
    }()
    
    var lineImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "todoLine")
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
//        view.rowHeight = 68
        view.delegate = self
        view.dataSource = self
        view.register(WriteTableViewCell.self, forCellReuseIdentifier: WriteTableViewCell.reuseIdentifier)
        return view
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = Constants.Color.paper
        tableView.reloadData()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [tableView, titleLabel, lineImageView].forEach {
            backgroundView.addSubview($0)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        
        
    }
    
    func setConstraints() {
        let spacing = 40
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.leftMargin.equalTo(spacing)
            make.height.equalTo(view.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(backgroundView.safeAreaLayoutGuide)
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }

}

extension CardTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteTableViewCell.reuseIdentifier, for: indexPath) as? WriteTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
