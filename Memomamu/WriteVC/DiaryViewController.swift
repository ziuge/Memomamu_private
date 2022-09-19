//
//  DiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {
    
    // MARK: Realm
    let repository = Repository()
    var diary: Diary = Diary(date: "", diary: "", hasChanged: false)
    func fetchRealm() {
        diary = repository.fetchDiary(date: DateFormatter.dateOnly.string(from: Date()))
        diaryTextView.text = diary.diary
    }
    
    var todayDate: String = ""
    
    // MARK: UI
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
        view.isScrollEnabled = true
        
        return view
    }()
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    var saveButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.tintColor = Constants.Color.background
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if diary.date == "" && diary.diary == "" {
            print("==diary is nil")
            repository.addDiary(item: Diary(date: DateFormatter.dateOnly.string(from: Date()), diary: "", hasChanged: false))
            
        }
        fetchRealm()
        print("diary is:", diary)
        
        diaryTextView.delegate = self
        
        configure()
        setConstraints()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [titleLabel, lineImageView, diaryImageView, diaryTextView, saveButton].forEach {
            backgroundView.addSubview($0)
        }
    }
    func setConstraints() {
        
        let spacing = 16
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.rightMargin.equalTo(-spacing)
            make.height.equalTo(view.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(36)
        }
        
        lineImageView.snp.makeConstraints { make in
            make.width.equalTo(backgroundView).multipliedBy(0.768)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.topMargin.equalTo(lineImageView.snp.bottom).offset(50)
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
        
        saveButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backgroundView).offset(20)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-36)
            make.height.width.equalTo(21)
        }

    }
    
    @objc func saveButtonClicked() {
        print(#function)
        repository.updateDiary(oldValue: diary, newValue: diaryTextView.text)
        fetchRealm()
    }
    
    func setData(data: Diary) {
        diaryTextView.text = data.diary
    }
}

// MARK: - textView Delegate
extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if diary.hasChanged == false {
            diaryTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if diaryTextView.text == "" {
            diaryTextView.text = "오늘 하루를 작성해보세요 :)"
            repository.diaryChanged(item: diary)
        } else {
            saveButtonClicked()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if diary.hasChanged == false {
            repository.diaryChanged(item: diary)
        } else if diary.hasChanged == true && diary.diary == "" {
            repository.diaryChanged(item: diary)
        }
    }
}
