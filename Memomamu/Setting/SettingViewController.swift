//
//  SettingViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/12.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case total, developer
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["알림 설정", "글자 크기", "테마 설정"]
        case .developer:
            return ["문의하기", "개발팀 정보"]
        }
    }
}

class SettingViewController: BaseViewController {
    
    // MARK: UI
    var logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame"))
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
        view.backgroundColor = Constants.Color.background
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
    }
    
    override func configure() {
        [logoImageView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 16
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(84.7)
            make.height.equalTo(49)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(view).offset(spacing * 2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(spacing * 2)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}

// MARK: TableView Delegate, DataSource
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].rowTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = ":) " + SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
}
