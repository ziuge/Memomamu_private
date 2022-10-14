//
//  CardDiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class CardDiaryViewController: BaseViewController {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var diary: Diary? = nil
    func fetchRealm() {
        diary = repository.fetchDiary(date: selectedDate)
        if diary?.diary == nil || diary?.diary == "" {
            diaryNilLabel.isHidden = false
//            diaryImageView.isHidden = true
            diaryTextView.isHidden = true
        } else {
            diaryNilLabel.isHidden = true
            diaryTextView.isHidden = false
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
        view.image = UIImage(named: "cardDiaryTextViewBox")
        return view
    }()
    var diaryTextView: UITextView = {
        let view = UITextView()
        view.text = NSLocalizedString("WriteDiary", comment: "다이어리 작성 문구")
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
    var diaryNilLabel: UILabel = {
        let view = UILabel()
        view.text = NSLocalizedString("WriteDiary", comment: "다이어리 작성 문구")
        view.textAlignment = .center
        view.font = Constants.Font.content
        view.textColor = Constants.Color.background.withAlphaComponent(0.6)
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()
    var clickButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm()
        
        clickButton.addTarget(self, action: #selector(goTodo), for: .touchUpInside)
    }
    
    override func configure() {
        view.addSubview(backgroundView)
        [titleLabel, diaryImageView, diaryTextView, diaryNilLabel].forEach {
            backgroundView.addSubview($0)
        }
        view.addSubview(clickButton)
    }
    override func setConstraints() {
        let spacing = 40
        
        clickButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundView)
        }
        
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
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.26)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.78)
            make.centerX.equalTo(backgroundView)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.24)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.68)
            make.centerX.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView)
        }

        diaryNilLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView).offset(-8)
        }
    }
    
    @objc func goTodo() {
        let vc = WriteViewController()
        vc.selectedDate = self.selectedDate
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        vc.vc.setViewControllers([vc.vc.vc2], direction: .forward, animated: true)
    }
}


