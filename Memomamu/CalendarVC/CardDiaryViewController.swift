//
//  CardDiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class CardDiaryViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "diary"
        view.font = Constants.Font.title
        view.textColor = Constants.Color.background
        return view
    }()
    
    var lineImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "todoLine")
        return view
    }()
    
    var diaryImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "diaryTextViewBox")
        return view
    }()
    
    var diaryTextView: UITextView = {
        let view = UITextView()
        view.text = "오늘 하루를 작성해보세요 :)"
        view.font = Constants.Font.content
        view.textColor = Constants.Color.background
        view.backgroundColor = .clear
        return view
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [titleLabel, lineImageView, diaryImageView, diaryTextView].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    func setConstraints() {
        let spacing = 40
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.rightMargin.equalTo(-spacing)
            make.height.equalTo(view.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(24)
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.42)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.77)
            make.centerX.equalTo(backgroundView)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.38)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.67)
            make.centerX.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView)
        }

    }
    
}
