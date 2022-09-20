//
//  CardDiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class CardDiaryViewController: UIViewController {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var diary: Diary? = nil
    func fetchRealm() {
        diary = repository.fetchDiary(date: selectedDate)
        if diary == nil {
            diaryTextView.text = "to do를 먼저 작성하세요 :("
            diaryTextView.textColor = Constants.Color.background.withAlphaComponent(0.6)
        } else {
            diaryTextView.text = diary!.diary
            diaryTextView.textColor = Constants.Color.background
        }
    }
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "diary"
        view.font = Constants.Font.cardTitle
        view.textColor = Constants.Color.background
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
        view.textColor = Constants.Color.background.withAlphaComponent(0.6)
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
        
        fetchRealm()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [titleLabel, diaryImageView, diaryTextView].forEach {
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


