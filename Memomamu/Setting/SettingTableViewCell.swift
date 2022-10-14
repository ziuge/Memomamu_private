//
//  SettingTableViewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/14.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.text
        view.font = Constants.Font.content
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.Color.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 16
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(spacing * 2)
            make.centerY.equalTo(contentView)
        }
    }
}
