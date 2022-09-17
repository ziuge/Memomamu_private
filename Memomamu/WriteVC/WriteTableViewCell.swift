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
    
    var todoTextView: UITextView = {
        let view = UITextView()
        view.textColor = Constants.Color.background
        view.font = Constants.Font.content
        view.text = "할 일을 작성하세요 :)"
        view.isEditable = true
        view.returnKeyType = .next
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        view.backgroundColor = .clear
        view.textContainer.maximumNumberOfLines = 0
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
        [checkButton, todoTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setData(data: Todo) {
        todoTextView.text = data.todo
        checkButton.setImage(UIImage(named: "pencil"), for: .selected)
    }
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(todoTextView.snp.top).offset(4)
//            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(contentView).offset(52)
            make.height.width.equalTo(26)
        }
        
        todoTextView.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(4)
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
    }
    
}
