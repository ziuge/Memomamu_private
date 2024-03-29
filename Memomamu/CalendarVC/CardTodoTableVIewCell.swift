//
//  CardTodoTableVIewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/22.
//

import UIKit

class CardTodoTableVIewCell: BaseTableViewCell {
    
    let checkList = ["unchecked", "finished", "delayed", "unfinished"]

    var checkButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todoButton-notChecked.jpg"), for: .normal)
        return view
    }()
    var todoTextView: UITextView = {
        let view = UITextView()
        view.textColor = Constants.Color.background
        view.font = Constants.Font.smallContent
        view.text = NSLocalizedString("WriteTodo", comment: "할 일 작성 문구")
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Todo) {
        todoTextView.text = data.todo
        if checkList[data.check] == "finished" {
            checkButton.setImage(UIImage(named: "finished-\(data.color)"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: checkList[data.check]), for: .normal)
        }
        
    }
    
    override func configure() {
        [checkButton, todoTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView)
            make.leadingMargin.equalTo(contentView).offset(6)
            make.height.width.equalTo(14)
        }
        
        todoTextView.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(-8)
            make.bottomMargin.equalTo(contentView)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
    }
}

