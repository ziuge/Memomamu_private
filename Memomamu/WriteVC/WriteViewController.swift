//
//  WriteViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit
import SnapKit

class WriteViewController: UIViewController {
    
    var selectedDate = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: UI
    var viewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "calendar"), for: .normal)
        view.tintColor = Constants.Color.text
        view.configuration?.buttonSize = .large
        return view
    }()
    
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
        configure()
        setConstraints()
        addPageVC()
        
        viewButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
    }
    
    func stringToDate(string: String) -> Date {
        let selectedDate = string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        formatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
        formatter.locale = Locale(identifier: "en_US")
        let date = formatter.date(from: selectedDate)!
        return date
    }
    
    func dateToString(date: Date) -> String {
        let date = date
        let formatter = DateFormatter()
        formatter.dateFormat = "d, MMMM"
        formatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
        formatter.locale = Locale(identifier: "en_US")
        let string = formatter.string(from: date)
        return string
    }
    
    func configure() {
        [containerView, viewButton, dateLabel].forEach {
            view.addSubview($0)
        }
        
    }
    func setConstraints() {
        viewButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.067)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(40)
        }

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
    
    @objc func openCalendar() {
        let vc = CalendarViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}

