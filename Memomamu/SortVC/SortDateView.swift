//
//  SortDateView.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit

class SortDateView: UIView {
    let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "17, April"
        view.numberOfLines = 2
        view.font = Constants.Font.cardTitle
        view.textColor = Constants.Color.text
        return view
    }()
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
        view.layer.borderWidth = 0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 8, height: 0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5.0
        return view
    }()
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        self.backgroundColor = Constants.Color.background
        [backgroundView, topView, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self).offset(36)
        }
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView)
            make.top.equalTo(backgroundView).offset(-12)
            make.bottom.equalTo(backgroundView).offset(12)
        }
    }
}
