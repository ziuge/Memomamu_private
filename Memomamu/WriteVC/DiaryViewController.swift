//
//  DiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.paper
        
        configure()
        setConstraints()
    }
    
    func configure() {
        [titleLabel, lineImageView, diaryImageView, diaryTextView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.topMargin.equalTo(view).offset(36)
        }
        
        lineImageView.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.768)
            make.centerX.equalTo(view)
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.topMargin.equalTo(lineImageView.snp.bottom).offset(50)
            make.height.equalTo(view.snp.height).multipliedBy(0.65)
            make.width.equalTo(view.snp.width).multipliedBy(0.77)
            make.centerX.equalTo(view)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.56)
            make.width.equalTo(view.snp.width).multipliedBy(0.67)
            make.centerX.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView)
        }

    }
    
}
