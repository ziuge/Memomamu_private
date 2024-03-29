//
//  WriteTableViewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func didTapCheck(with status: String)
}

class WriteTableViewCell: BaseTableViewCell {
    
    weak var delegate: MyTableViewCellDelegate?
    
    var checkButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todoButton-notChecked.jpg"), for: .normal)
        return view
    }()
    var todoTextView: UITextView = {
        let view = UITextView()
        view.textColor = Constants.Color.background
        view.font = Constants.Font.content
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
    let finishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle(NSLocalizedString("FinishedButton", comment: "Finish"), for: .normal)
        view.titleLabel?.font = Constants.Font.content
        
        return view
    }()
    let delayedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle(NSLocalizedString("DelayedButton", comment: "Delayed"), for: .normal)
        view.titleLabel?.font = Constants.Font.content
        view.intrinsicContentSize.width
        return view
    }()
    let unfinishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle(NSLocalizedString("UnfinishedButton", comment: "Unfinished"), for: .normal)
        view.titleLabel?.font = Constants.Font.content
        view.intrinsicContentSize.width
        return view
    }()
    let deleteButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.text
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle(NSLocalizedString("DeleteButton", comment: "Delete"), for: .normal)
        view.titleLabel?.font = Constants.Font.content
        view.intrinsicContentSize.width
        return view
    }()
//    var stackView: UIStackView = {
//        let view = UIStackView()
//        return view
//    }()
    var changeCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        view.isHidden = false
        return view
    }()
    var clickButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    var deleteHidden: Bool = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.paper
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let checkList = ["unchecked", "finished", "delayed", "unfinished"]
    
    func setData(data: Todo) {
        todoTextView.text = data.todo
        todoTextView.setLineAndLetterSpacing(data.todo!)
        todoTextView.font = Constants.Font.content
        todoTextView.textColor = Constants.Color.background
        if checkList[data.check] == "finished" {
            checkButton.setImage(UIImage(named: "finished-\(data.color)"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: checkList[data.check]), for: .normal)
        }
    }

    @objc func showCheckStatusChangeButton() {
        changeCheckView.isHidden.toggle()
    }
    
    var status: String = "unchecked"
    
    func didTapCheck() {
        delegate?.didTapCheck(with: status)
    }
    
    override func configure() {
        [checkButton, todoTextView, finishedButton, delayedButton, unfinishedButton, deleteButton, changeCheckView, clickButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        clickButton.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        
        checkButton.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(8)
            make.leadingMargin.equalTo(contentView).offset(12)
            make.height.width.equalTo(26)
        }
        
        todoTextView.snp.makeConstraints { make in
            make.bottomMargin.equalTo(contentView).offset(-18)
            make.top.equalTo(checkButton.snp.top).offset(-4)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
        
        changeCheckView.snp.makeConstraints { make in
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(todoTextView.snp.leading)
            make.trailing.equalTo(todoTextView.snp.trailing).offset(20)
            make.height.equalTo(26)
            
        }

        finishedButton.snp.makeConstraints { make in
            make.height.equalTo(26)
//            make.width.equalTo(40)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(todoTextView.snp.leading)
        }
        
        delayedButton.snp.makeConstraints { make in
            make.height.equalTo(26)
//            make.width.equalTo(40)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(finishedButton.snp.trailing).offset(8)
        }
        
        unfinishedButton.snp.makeConstraints { make in
            make.height.equalTo(26)
//            make.width.equalTo(54)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(delayedButton.snp.trailing).offset(8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(26)
//            make.width.equalTo(40)
            make.top.equalTo(todoTextView.snp.bottom)
            make.leading.equalTo(unfinishedButton.snp.trailing).offset(8)
        }
    }
    
}
