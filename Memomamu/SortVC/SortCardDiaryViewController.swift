//
//  SortCardDiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit

class SortCardDiaryViewController: UIViewController {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var diary: Diary? = nil
    func fetchRealm() {
        diary = repository.fetchDiary(date: selectedDate)
        if diary?.diary == nil || diary?.diary == "" {
            diaryNilLabel.isHidden = false
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
        view.textAlignment = .left
        return view
    }()
    var diaryImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cardDiaryTextViewBox")
        return view
    }()
    var diaryTextView: UITextView = {
        let view = UITextView()
        view.text = "오늘 하루를 작성해보세요 :)                                                       "
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
        view.text = "to do를 먼저 작성하세요 :("
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
        
        configure()
        setConstraints()
        clickButton.addTarget(self, action: #selector(goTodo), for: .touchUpInside)
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [titleLabel, diaryImageView, diaryTextView, diaryNilLabel].forEach {
            backgroundView.addSubview($0)
        }
        view.addSubview(clickButton)
    }
    func setConstraints() {
        let spacing = 12
        
        clickButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundView)
        }
        
        backgroundView.snp.makeConstraints { make in
//            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.rightMargin.equalTo(-spacing)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(backgroundView).offset(12)
            make.topMargin.equalTo(backgroundView).offset(12)
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.8)
//            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.9)
            make.leftMargin.equalTo(backgroundView).offset(12)
            make.rightMargin.equalTo(backgroundView).offset(-12)
            make.centerX.equalTo(backgroundView)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.74)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.88)
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
    }
}
