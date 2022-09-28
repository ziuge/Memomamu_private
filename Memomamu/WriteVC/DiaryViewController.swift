//
//  DiaryViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var diary: Diary? = nil
    func fetchRealm() {
        diary = repository.fetchDiary(date: selectedDate)
        diaryTextView.text = (diary != nil) ? diary!.diary : "오늘 하루를 작성해보세요 :)                                                       "
    }
    
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
        view.text = "오늘 하루를 작성해보세요 :)                                                       "
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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRealm()
        
        if diary == nil {
            repository.addDiary(item: Diary(date: selectedDate, diary: ""))
            diaryTextView.textColor = Constants.Color.background.withAlphaComponent(0.6)
            fetchRealm()
            
        }
        if diaryTextView.text == "" || diaryTextView.text == "오늘 하루를 작성해보세요 :)                                                       " {
            diaryTextView.text = "오늘 하루를 작성해보세요 :)                                                       "
            diaryTextView.textColor = Constants.Color.background.withAlphaComponent(0.6)
        }
        diaryTextView.delegate = self
        
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
        
        let spacing = 16
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.height.equalTo(view.snp.height).multipliedBy(0.76)
            make.top.leading.equalTo(view)
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
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.64)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.77)
            make.centerX.equalTo(backgroundView)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.62)
            make.width.equalTo(backgroundView.snp.width).multipliedBy(0.67)
            make.centerX.equalTo(diaryImageView)
            make.centerY.equalTo(diaryImageView)
        }
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        repository.updateDiary(oldValue: diary!, newValue: diaryTextView.text)
        fetchRealm()
    }
    
    @objc func finishButtonClicked() {
        print("finish!")
    }
    
    func setData(data: Diary) {
        diaryTextView.text = data.diary
    }
}

// MARK: - textView Delegate
extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if diaryTextView.text == "오늘 하루를 작성해보세요 :)                                                       " {
            diaryTextView.text = ""
            diaryTextView.textColor = Constants.Color.background
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if diaryTextView.text == "" {
            diaryTextView.text = "오늘 하루를 작성해보세요 :)                                                       "
            diaryTextView.textColor = Constants.Color.background.withAlphaComponent(0.6)
        } else {
            saveButtonClicked()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
}
