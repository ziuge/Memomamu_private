//
//  SortCardDiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit

class SortCardDiaryViewController: BaseViewController {
    
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
    
    // MARK: UI
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
        view.text = NSLocalizedString("WriteDiary", comment: "다이어리 작성 문구")
        view.font = Constants.Font.smallContent
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
        view.font = Constants.Font.smallContent
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
        let spacing = 12
        
        clickButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundView)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-spacing)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(backgroundView).offset(12)
            make.topMargin.equalTo(backgroundView).offset(22)
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(22)
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.7)
            make.leftMargin.equalTo(backgroundView).offset(12)
            make.rightMargin.equalTo(backgroundView).offset(-18)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.centerX.equalTo(diaryImageView)
            make.top.bottom.equalTo(diaryImageView)
            make.leading.equalTo(diaryImageView.snp.leading).offset(2)
            make.trailing.equalTo(diaryImageView.snp.trailing).offset(-2)
        }

        diaryNilLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView).offset(-8)
        }
    }
    
    @objc func goTodo() {
        let vc = WriteViewController()
        vc.selectedDate = self.selectedDate
        vc.isDiarySelected = true
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
