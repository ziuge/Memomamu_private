//
//  WriteTableViewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit

class WriteTableViewCell: UITableViewCell {
    
    var checkButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todoButton-notChecked.jpg"), for: .normal)
        return view
    }()
    
    var todoLabel: UITextField = {
        let view = UITextField()
        view.textColor = Constants.Color.background
        view.font = Constants.Font.content
        view.placeholder = "할 일을 작성하세요 :)"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.paper
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure() {
        [checkButton, todoLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(contentView).offset(52)
            make.height.width.equalTo(26)
        }
        
        todoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
    }
    
}
