//
//  WriteViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit
import SnapKit

class WriteViewController: BaseViewController {
    
    var selectedDate = DateFormatter.dateOnly.string(from: Date())
    var isDiarySelected = false
    
    // MARK: UI
    var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.text
        view.text = DateFormatter.titleDate.string(from: Date())
        view.font = Constants.Font.head
        return view
    }()
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        
        let rawDate = stringToDate(string: selectedDate)
        dateLabel.text = dateToString(date: rawDate)

        addPageVC()
        
        if isDiarySelected == true {
            vc.setViewControllers([vc.vc2], direction: .forward, animated: true)
        }
        
        self.navigationController?.navigationBar.tintColor = Constants.Color.text
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func configure() {
        [containerView, dateLabel].forEach {
            view.addSubview($0)
        }
        
    }
    override func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(view.frame.height * 0.08)
            make.centerX.equalTo(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(view.frame.height * 0.18)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(view).multipliedBy(0.60)
            make.bottom.equalTo(view)
        }
    }
    
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let vc1 = TodoViewController()
    let vc2 = DiaryViewController()
    
    func addPageVC() {
        vc1.selectedDate = selectedDate
        vc2.selectedDate = selectedDate
        vc.vc1 = vc1
        vc.vc2 = vc2
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.selectedDate = selectedDate
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(containerView)
        }
    }
}

