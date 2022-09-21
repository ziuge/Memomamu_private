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
//    var deleteButton: UIButton = {
//        let view = UIButton()
//        view.setImage(UIImage(systemName: "trash"), for: .normal)
//        view.tintColor = .red
//        view.isHidden = true
//        return view
//    }()
    let finishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("완료", for: .normal)
        view.titleLabel?.font = Constants.Font.content
        return view
    }()
    let delayedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("연기", for: .normal)
        view.titleLabel?.font = Constants.Font.content
        return view
    }()
    let unfinishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("미완료", for: .normal)
        view.titleLabel?.font = Constants.Font.content
        return view
    }()
    
    var changeCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        view.isHidden = false
        return view
    }()
    
    var deleteHidden: Bool = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.paper
        
        configure()
        setConstraints()
        checkButton.addTarget(self, action: #selector(showCheckStatusChangeButton), for: .touchUpInside)
//        finishedButton.addTarget(self, action: #selector(changeCheck), for: .touchUpInside)
//        CheckStatusButtonView().finishedButton.addTarget(self, action: #selector(checkFinished), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Todo) {
        todoTextView.text = data.todo
        checkButton.setImage(UIImage(named: check.unchecked.checkInfo), for: .normal)
    }
    
    var completionHandler: (() -> Void)? = nil
    
    let checkList = ["unchecked", "finished", "delayed", "unfinished"]
    @objc func changeCheck() {
        print(#function)
        checkButton.setImage(UIImage(named: "delayed.jpg"), for: .normal)
        changeCheckView.isHidden = false
    }
    
    @objc func showCheckStatusChangeButton() {
        changeCheckView.isHidden.toggle()
    }
    
    func configure() {
        [checkButton, todoTextView, finishedButton, delayedButton, unfinishedButton, changeCheckView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(todoTextView.snp.top).offset(8)
            make.leadingMargin.equalTo(contentView).offset(12)
            make.height.width.equalTo(26)
        }
        
        todoTextView.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(8)
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
        
        changeCheckView.snp.makeConstraints { make in
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(todoTextView.snp.leading)
            make.height.equalTo(32)
            make.width.equalTo(160)
        }

        finishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(todoTextView.snp.leading)
        }
        
        delayedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(finishedButton.snp.trailing).offset(8)
        }
        
        unfinishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(54)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(delayedButton.snp.trailing).offset(8)
        }
        
//        delete button ... swipe gesture 해결하고 나서 할 것!
//        deleteButton.snp.makeConstraints { make in
//            make.leading.equalTo(todoTextView.snp.trailing)
//            make.centerY.equalTo(todoTextView)
//        }
    }
    
}
