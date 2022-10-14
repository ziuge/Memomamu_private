//
//  CheckStatusButtonView.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/21.
//

import UIKit

class CheckStatusButtonView: BaseView {
    
    let finishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("완료", for: .normal)
        return view
    }()
    let delayedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("연기", for: .normal)
        return view
    }()
    let unfinishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("미완료", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configure() {
        self.backgroundColor = Constants.Color.paper
        [finishedButton, delayedButton, unfinishedButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        finishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
            make.top.leading.equalTo(self.safeAreaLayoutGuide)
        }
        
        delayedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(finishedButton.snp.trailing).offset(8)
        }
        
        unfinishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(54)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(delayedButton.snp.trailing).offset(8)
        }
    }
}
