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
        view.backgroundColor = .yellow
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.paper
        todoTextView.delegate = self
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
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(contentView).offset(52)
            make.height.width.equalTo(26)
        }
        
        todoTextView.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView)
            make.topMargin.equalTo(self).offset(14)
            make.bottomMargin.equalTo(self).offset(-14)
            make.leadingMargin.equalTo(checkButton.snp.trailing).offset(15)
            make.trailingMargin.equalTo(contentView).offset(-52)
        }
    }
    
}

extension WriteTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height <= 68 {
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
