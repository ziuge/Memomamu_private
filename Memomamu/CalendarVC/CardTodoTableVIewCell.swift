//
//  CardTodoTableVIewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/22.
//

import UIKit

class CardTodoTableVIewCell: UITableViewCell {
    
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
    
    func setData(data: Todo) {
        todoTextView.text = data.todo
        checkButton.setImage(UIImage(named: checkList[data.check]), for: .normal)
    }
    
    var completionHandler: (() -> Void)? = nil
    
    @objc func changeCheck() {
        print(#function)
        checkButton.setImage(UIImage(named: "finished.jpg"), for: .normal)
    }
    
    @objc func changeCheckDelayed() {
        checkButton.setImage(UIImage(named: "delayed.jpg"), for: .normal)
    }
    
    @objc func changeCheckUnfinished() {
        checkButton.setImage(UIImage(named: "unfinished.jpg"), for: .normal)
    }
    
    @objc func showCheckStatusChangeButton() {
    }

    func configure() {
        [checkButton, todoTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView)
            make.leadingMargin.equalTo(contentView).offset(6)
            make.height.width.equalTo(14)
        }
        
        todoTextView.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(-8)
            make.bottomMargin.equalTo(contentView)
//            make.centerY.equalTo(contentView)
//            make.top.equalTo(checkButton.snp.top)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
    }
}
