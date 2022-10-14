//
//  SortDateView.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit

class SortDateView: BaseView {
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
//        view.layer.borderWidth = 0
//        view.layer.masksToBounds = false
//        view.layer.shadowColor = UIColor.yellow.cgColor
//        view.layer.shadowOffset = CGSize(width: 8, height: 0)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 5.0
        return view
    }()
    let shadowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shadow")
        return image
    }()
    let topView: UIView = {
        let view = UIView()
//        view.backgroundColor = Constants.Color.background
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configure() {
        self.backgroundColor = Constants.Color.background
        [backgroundView, dateLabel, shadowImage].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self).offset(36)
        }
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        shadowImage.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView.snp.trailing)
            make.top.equalTo(backgroundView)
            make.bottom.equalTo(backgroundView)
        }
    }
}
